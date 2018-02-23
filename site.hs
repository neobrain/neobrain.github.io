--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import Control.Monad (filterM)
import Data.Maybe (fromJust, fromMaybe, isNothing)
import Data.Monoid (mappend)
import Data.List (reverse, stripPrefix)
import qualified Data.Text as T (pack)
import Hakyll

import qualified Network.Gravatar as Gravatar

--------------------------------------------------------------------------------
main :: IO ()
main = hakyll $ do
    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match (fromList ["about.markdown", "contact.markdown"]) $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "posts/*.markdown" $ do
        route $ setExtension "html"
        compile $
            do
              resource <- getResourceString
              let ident = itemIdentifier resource
              let filename = reverse $ fromJust $ stripPrefix "nwodkram." $ reverse $ fromJust $ stripPrefix "posts/" $ toFilePath ident
              comments <- loadAll $ fromGlob $ "blog_comments/" ++ filename ++ "/*"

              -- Top level comments = comments without replies
              let isTopLevelComment comment = do
                    parentId <- getMetadataField (itemIdentifier comment) "parent_id"
                    return $ isNothing parentId

              let getChildrenOf potentialChildren comment = do
                    Just comment_id <- getMetadataField (itemIdentifier comment) "comment_id"
                    let isChild potentialChild = do
                          parentId <- getMetadataField (itemIdentifier potentialChild) "parent_id"
                          return $ maybe False (comment_id==) parentId
                    filterM isChild potentialChildren

              -- Build a hierachy of comments so we can sort replies and toplevel comments independently
              commentsHierarchy <- do
                topLevelComments <- filterM isTopLevelComment comments
                children <- mapM (getChildrenOf comments) topLevelComments
                return $ zip topLevelComments children

              -- TODO: Sort comments within the hierarchy by date!

              -- Enumerate comment indices
              let topLevelIndices = scanl (\index (_, children) -> succ index + length children) 1 commentsHierarchy

              -- Fill in template placeholders for childs (i.e. comment index only)
              let transformChildComment (comment, commentIndex) = do
                    let newCtx =  constField "comment_index" (show commentIndex) `mappend`
                                  defaultContext
                    applyAsTemplate newCtx comment

              -- Fill in template placeholders for childs (i.e. comment index and replies)
              let transformTopLevelComment ((comment, children), commentIndex) = do
                    processedChildren <- mapM transformChildComment $ zip children [succ commentIndex..]
                    Just comment_id <- getMetadataField (itemIdentifier comment) "comment_id"
                    let newCtx =  constField "comment_index" (show commentIndex) `mappend`
                                  constField "is_toplevel" "1" `mappend`
                                  defaultContext

                    -- Add replies unless there are none
                    let newCtx' = if null processedChildren
                                  then newCtx
                                  else newCtx `mappend` listField "child_comments" defaultContext (return processedChildren)

                    applyAsTemplate newCtx' comment

              processedComments <- mapM transformTopLevelComment $ zip commentsHierarchy topLevelIndices

              let fullCtx = constField "num_comments" (show $ pred $ last topLevelIndices) `mappend` -- count both toplevel comments and replies
                            listField "comments" postCtx (return processedComments) `mappend`
                            postCtx

              pandocCompiler
                >>= saveSnapshot "content" -- save snapshot for teaser text
                >>= loadAndApplyTemplate "templates/post.html"    fullCtx -- TODO: May need to split off comments now...
                >>= saveSnapshot "content"
                >>= loadAndApplyTemplate "templates/default.html" fullCtx
                >>= relativizeUrls

    match "talks/*markdown" $ do
        route $ setExtension "html"
        compile $
            do
              let fullCtx = postCtx

              pandocCompiler
                >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Archives"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls


    match "index.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let indexCtx =
                    listField "posts" (postCtx `mappend` teaserField "teaser" "content") (return posts) `mappend`
                    constField "title" "Blog"                `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate indexCtx
                >>= loadAndApplyTemplate "templates/default.html" indexCtx
                >>= relativizeUrls

    match "resume.html" $ do
        route idRoute
        compile $ do
            let pageCtx = defaultContext

            getResourceBody
                >>= applyAsTemplate pageCtx
                >>= loadAndApplyTemplate "templates/default.html" pageCtx
                >>= relativizeUrls

    match "talks.html" $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "talks/*"
            let pageCtx =
                    listField "talks" postCtx (return posts) `mappend`
                    defaultContext

            getResourceBody
                >>= applyAsTemplate pageCtx
                >>= loadAndApplyTemplate "templates/default.html" pageCtx
                >>= relativizeUrls

    match "templates/*" $ compile templateBodyCompiler
    match "blog_comments/*/*.markdown" $ compile $ do
      -- TODO: Verify the comment_ids for all comments are unique
      comment <- getResourceString
      email <- getMetadataField (itemIdentifier comment) "email"
      Just name <- getMetadataField (itemIdentifier comment) "name"
      let commentCtx =  defaultContext `mappend`
                        -- Generate link to gravatar using the given email address; if none was specified, generate a dummy image from the name
                        (constField "gravatar_url" . Gravatar.gravatar gravatarConfig . T.pack) (fromMaybe ("dummy_email_" ++ name) email)
                        where gravatarConfig = Gravatar.def { Gravatar.gDefault = Just Gravatar.Identicon }

      -- Preprocessing body: This will fill in all placeholders other than the comment index
      -- We also make sure to escape special HTML characters here
      resource <- getResourceBody
      withItemBody (return . escapeHtml) resource
        >>= loadAndApplyTemplate "templates/blog_comment.html" commentCtx
        >>= relativizeUrls


--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext
