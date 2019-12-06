# Contributing to _pantograph_

## I want to report a problem or ask a question

Before submitting a new GitHub issue, please make sure to

- Check out [johnknapprs.github.io/pantograph](https://johnknapprs.github.io/pantograph)
- Check out the README pages on [this repo](https://github.com/pantograph/pantograph)
- Search for [existing GitHub issues](https://github.com/johnknapprs/pantograph/issues)

If the above doesn't help, please [submit an issue](https://github.com/johnknapprs/pantograph/issues)
on GitHub and provide information about your setup, in particular the output of the `pantograph env` command.

**Note**: If you want to report a regression in _pantograph_ (something that has worked before, but broke with a new release),
please mark your issue title as such using `[Regression] Your title here`. This enables us to quickly detect and fix regressions.

## I want to contribute to _pantograph_

- To start working on _pantograph_, check out [YourFirstPR.md][firstpr]
- For some more advanced tooling and debugging tips, check out [ToolsAndDebugging.md](ToolsAndDebugging.md)

### New Actions

Please be aware that we don’t accept submissions for new actions at the moment.
You can find more information about that [here][submit action].

## I want to help work on _pantograph_ by reviewing issues and PRs

Thanks! We would really appreciate the help!
Feel free to read our document on how to [respond to issues and PRs][responding to prs] and also check out how
to become a [core contributor][core contributor].

## Why did my issue/PR get closed?

* The user later decided not to use _pantograph_
* A workaround was found, making it a low priority for the user
* The user changed projects and/or companies
* A new version of _pantograph_ has been released that fixed the problem

In any case, **a closed issue is not necessarily the end of the story!**
If more info becomes available after an issue is closed, it can be reopened for further consideration.

One of the best ways we can keep _pantograph_ an approachable, stable, and dependable tool is to be deliberate
about how we choose to modify it. If we don't adopt your changes or new feature into _pantograph,_
that doesn't mean it was bad work! It may be that the _pantograph_ philosophy about how to accomplish
a particular task doesn't align well with your approach.
The best way to make sure that your time is well spent in contributing to _pantograph_ is
to **start your work** on a modification or new feature **by opening an issue to discuss the problem or shortcoming with the community**.
The _pantograph_ maintainers will do our best to give early feedback about whether a particular goal
and approach is likely to be something we want to adopt!

## Code of Conduct

Help us keep _pantograph_ open and inclusive. Please read and follow our [Code of Conduct][code of conduct].

## Above All, Thanks for Your Contributions

Thank you for reading to the end, and for taking the time to contribute to the project!
If you include the 🔑 emoji at the top of the body of your issue or pull request,
we'll know that you've given this your full attention and are doing your best to help!

## License

This project is licensed under the terms of the MIT license. See the [LICENSE][license] file.


<!-- Links: -->
[code of conduct]: CODE_OF_CONDUCT.md
[core contributor]: CORE_CONTRIBUTOR.md
[license]: LICENSE
[tools and debugging]: ToolsAndDebugging.md
[vision]: VISION.md
[responding to prs]: RespondingToIssuesAndPullRequests.md
[plugins]: https://johnknapprs.github.io/pantograph/plugins/create-plugin/
[firstpr]: YourFirstPR.md
[submit action]: https://johnknapprs.github.io/pantograph/plugins/create-plugin/#submitting-the-action-to-the-pantograph-main-repo
