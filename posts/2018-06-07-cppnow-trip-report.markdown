---
title: C++Now 2018 Trip Report
author: Tony Wasserka
tags: C++, Conference
---

I've had the opportunity of attending this year's C++Now conference, and it's been nothing short of an amazing trip. I figured I'd share the experience, explain what exactly makes this conference such a great event, and what distinguishes it from other conferences.

<!--more-->

## The Conference

C++Now is *the* conference to get in touch with a large group of C++ experts &mdash; whether that's compiler developers, standard proposal writers, library authors, or others. While you might expect this to be somewhat of an exclusive club, it's quite the opposite: People are very open-minded and approachable, especially so since there's a relatively small number of about 150 attendees, and there's plenty of time between talks to have a chat with everyone if you want to keep yourself busy. Anecdotally, on my first day I even had the pleasure of casually meeting the head of Google's clang team in a taxi ride to the hotel!

Among the C++-focussed conferences, it's probably fair to say C++Now is the place that shapes the future of the language most: When you attend C++Now, you will see many proposals (or just drafts of them even) being discussed for the first time, and regularly see people having heated discussions on how best to implement new library features (and what language extensions might be needed to do so). Even for non-C++-experts (if there is such a thing anyway), following these discussion is often a very insightful experience.

The conference is hosted in Aspen, which is usually known for its appeal as a ski resort, and it's a truly remarkable venue. I've rarely seen a beautiful landscape like that, and it's refreshing to be able to sit outside the lecture rooms in a very quiet and relaxing atmosphere. We have been quite lucky with the weather this year too, being able to enjoy pleasant 20&nbsp;°C for the entire week. Overall, this gave the conference a very vacation-y feeling at times.

## The Talks

C++Now talks are usually quite cutting edge, and the program covers a lot of different topics as well: Talks about upcoming Boost libraries, new standard proposals, or novel programming patterns are not uncommon, but there's also more application-oriented talks about specific tools or standard library features. Other conferences got me used to having maybe 2 or 3 personal "must-watch"s, but at C++Now I rarely found myself skipping a session slot, and more often than not I was quite struggling to decide which talk in a slot to go to!

The length of 90 minutes (including QA) per session seems long, but it allows speakers to go into greater detail than usually and it allows for very in-depth discussions with the audience throughout the talk. C++Now talks are much more interactive than I've seen elsewhere, greatly helped by the fact that regardless of the topic you can be sure there are still two or three other domain experts in the room. Hence, some sessions are outright designed around the slogan "Here's an idea, what do you think?" even. It's a really interesting dynamic when you see it live in the room &mdash; and it's quite hilarious when the speakers can't help but summarise ongoing discussions as "Chandler disagrees" for lack of better summaries.

I'd also like to applaud the Program Committee for the submission review process: Each speaker gets about 6 individual reviews (brief but to the point), which is very useful for accepted and rejected speakers alike to see where their abstract and outline can still be improved. This applied to [my own talk](https://cppnow2018.sched.com/event/EC7A/generative-programming-in-action-emulating-the-3ds) about modern C++ in 3DS emulation work as well, and I was quite humbled to see that a lot of people in the C++ community are interested in this rather specific domain.

Here are some of the talks I recommend [watching](https://www.youtube.com/user/BoostCon/videos), in no particular order. Of course, that's just from the talks I've personally seen &mdash; there's plenty of other interesting ones on C++Now's [YouTube channel](https://www.youtube.com/user/BoostCon/videos), though!


#### [The Shape of a Program &mdash; Lisa Lippincott](https://cppnow2018.sched.com/event/ELaE/opening-keynote-the-shape-of-a-program)

In the conference's opening keynote, Lisa spoke about her research on the question "Why do we rarely formally prove our programs correct?" and asked how we can come up with better mathematical tools for such proofs. To this end, she outlined her idea of linking [topological concepts](https://en.wikipedia.org/wiki/Topology) like open/closed sets and neighborhoods to software development, and how a program's control flow, assertions, and library abstractions fit into this framework. Coming from a mathematical background, she translates this idea into category theoretical terms towards the end of the presentation. That said, this isn't just theoretical &mdash; all of this discussion ties into a set of hypothetical C++ extensions that resembles contract-based programming quite a bit.

While this might sound really complicated, it ultimately boils down to simple intuition, and the presentation contains lots of beautiful illustrations that get the ideas across without prior mathematical knowledge. If you're into the kind of talks that change the way you think about programming, this is the one to go for!

#### [Boost.TMP: Your DSL for Metaprogramming &mdash; Odin Holmes](https://cppnow2018.sched.com/event/EC7B/boosttmp-your-dsl-for-metaprogramming)

Complaints about template metaprogramming causing big hits on compile-time are quite common, but few people actually understand where these hits come from. Odin spent a lot of time analyzing the problems of mpl-style TMP in this aspect and tried to find ways to get around them. This talk is basically the outcome of this research: A new template metaprogramming library optimised for minimal compile-time overhead.

I will have to watch the talk again, but my understanding is that the majority of compile-time overhead is caused by template instantiation of intermediate results (i.e. types) of TMP code. For example, when instantiating the value type <code class="cpp">is_class&lt;remove_reference&lt;MyClass&&gt;::type&gt;</code>, the compiler first needs to instantiate the inner <code class="cpp">std::remove_reference&lt;…&gt;</code> type, even though the programmer doesn't really care about this inner type. When chaining together long TMP computations, the overhead caused by this largely adds up the infamous compile-times.

Odin's novel approach is to compose operations like these using *template template parameters*&nbsp;(sic!) instead &mdash; the advantage being that intermediate results don't need to be instantiated until the programmer explicitly requests them to be.
This is similar to continuation-passing-style often used in functional languages, and the key is that template template parameters sort of enable lazy evaluation on the type-system level.

This talk certainly is proof that metaprogramming is not a solved problem, yet. There's still issues to be tackled, and the new library is a promising step towards a solution!

#### [Option(al) is Not a Failure &mdash; Phil Nash](https://cppnow2018.sched.com/event/EC7P/optional-is-not-a-failure)

Phil presented ongoing work by Herb Sutter about a language extension to get concise and reliable error-handling without the overhead exceptions have today in C++. To this end, Phil gave a very comprehensive overview of existing error handling paradigms, their respective benefits and drawbacks, and ultimately presented the proposed new approach.

I don't want to spoil any more of the talk since it was quite exciting to see where Phil's build-up was going &mdash; I definitely recommend watching the talk hence, but if you're in a rush you can look at [Herb's paper](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0709r0.pdf) directly. Suffice to say, it's exciting that we may finally have a good solution for this very old problem that is suitable even in resource-constrained and timing-critical environments like embedded systems.

#### [Debug C++ Without Running &mdash; Anastasia Kazakova](https://cppnow2018.sched.com/event/EC7g/debug-c-without-running)

How do our IDEs keep pace with an ever-increasing set of language features in C++? Going beyond just autocompletion, Anastasia provided an overview of recently introduced C++ features combined with the tools for code inspection or for refactoring added in various IDEs to help the developer work with them. One example was type deduction using "auto", which a good IDE provides the programmer with a way to tell the deduced type on request. Among other examples, CLion naturally is featured a lot (considering Anastasia works at JetBrains), but there are plenty of comparisons made with other IDEs like Visual Studio and Qt Creator.

Personally, I rarely find myself thinking about these "mini"-tools, but I agree having them is worthwhile, and I learned about a lot of neat ideas people had come up to make C++ easier to work in this talk. Anastasia also raised a good point in that most new language features need to be accompanied with an equivalent IDE tool but currently just aren't &mdash; and it's certainly interesting to consider how our daily workflow would look like if every new proposal had to come with proof-of-concept tooling before being accepted into the standard.

#### More talks

I was going to write up more talk summaries, but as time passed the videos already started appearing, so I figured I'd get what I have out of the door already. Here's a number of other talks I recommand watching, though:

##### [Modern C++ in Embedded Systems &mdash; Michael Caisse](https://cppnow2018.sched.com/event/EC7s/modern-c-in-embedded-systems)
##### [Undefined Behavior and Compiler Optimizations &mdash; John Regehr](https://cppnow2018.sched.com/event/ELaF/closing-keynote-undefined-behavior-and-compiler-optimizations)
##### [Futures Without Type Erasure &mdash; Vittorio Romeo](https://cppnow2018.sched.com/event/EC76/futures-without-type-erasure)
##### [A View to a View &mdash; Peter Bindels](https://cppnow2018.sched.com/event/EC7h/a-view-to-a-view)
##### [How Compilers Reason About Exceptions &mdash; Michael Spencer](https://cppnow2018.sched.com/event/EC7V/how-compilers-reason-about-exceptions)
##### [Easy to Use, Hard to Misuse: Declarative Style in C++ &mdash; Ben Deane](https://cppnow2018.sched.com/event/EC7i/easy-to-use-hard-to-misuse-declarative-style-in-c)
&nbsp;

## Conclusion

C++Now 2018 has been a very exciting and insightful conference for me, and if you hadn't heard about it yet I hope this report got you curious about it. I highly recommend going to C++Now if you ever get the chance to. Meanwhile, I'll certainly do my best to make it for next year.

See you then!
