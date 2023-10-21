# 🌱 Contributor Guidelines

By contributing you agree to the terms of the Candle Cookbook [License](./LICENSE) and [Code of Conduct](./CODE_OF_CONDUCT.md).

We welcome contributions from anyone who aligns with Our Mission and Our Principles -- all you need is a [GitHub Account](https://github.com/join).

**Contributor Checklist:**

- [ ] Read and adhere to our [Code of Conduct](./CODE_OF_CONDUCT.md)
- [ ] Install Candle Cookbook according to the [Developer Setup](./docs/DEV_ENV.md) guide
- [ ] For recipes: follow the formatting conventions in the [recipe template](./templates/recipe.md)
- [ ] Ensure `make cookbook` passes before submitting any changes
- [ ] Review Cookbook changes and test hyperlinks by running `make serve`
- [ ] For pull requests: follow the [PR Requirements](./docs/PR_REQS.md)

<br>

Here are some contribution ideas depending on your level of experience and familiarity with git, Rust and Candle.

### Junior Chef

* **Test out a recipe** -- complete the recipe step-by-step and suggest improvements to the language or instructions to make the recipe more clear. If you're comfortable with git, complete a pull request according to the [PR Requirements](PR_REQS.md). Otherwise you can open [a ticket](https://github.com/nogibjj/candle-cookbook/issues). 

* **Help build our community** -- pick an [open ticket](https://github.com/nogibjj/candle-cookbook/issues?q=is:issue%20is:open) and engage in the problem resolution process. Contribute to the discussion by offering guidance, solutions or by asking clarifying questions.

### Sous Chef

* **Improve a recipe** -- complete a recipe step-by-step and offer technical improvements or extensions. Submit your improvements as a pull request according to the [PR Requirements](PR_REQS.md). 

* **Resolve a bug** -- pick an [open ticket](https://github.com/nogibjj/candle-cookbook/issues?q=is:issue%20is:open) then test, validate and submit a solution by completeing a pull request according to the [PR Requirements](PR_REQS.md).

### Head Chef

* **Create a recipe** -- create your own recipe using the [recipe template](./templates/recipe.md) then test, validate and submit your recipe by completeing a pull request according to the [PR Requirements](PR_REQS.md).

* **Review a PR** -- pick [an open PR](https://github.com/nogibjj/candle-cookbook/pulls?=qis:pr%20is:open). First ensure the PR check has passed, then test and validate any code additions. Submit your review outcome in the comments section according to the traffic-light system. `@` tag one of the community leaders in your comment to finalise the merge.
    * 🔴 If the PR check has failed or there are major flaws write "NOT APPROVED" including your reasons
    * 🟡 If the PR needs minor changes (i.e. formatting/clarity) write "CHANGES REQUIRED" including your suggestions
    * 🟢 If the PR is merge ready write "VALIDATED & APPROVED" 
