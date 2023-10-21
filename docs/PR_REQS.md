# ✅ Pull Request Requirements

- [ ] Read and adhere to our [Contributor Guidelines](./CONTRIBUTING.md)
- [ ] Read and agree to our [Code of Conduct](./CODE_OF_CONDUCT.md)
- [ ] Install Candle Cookbook according to the [Developer Setup](./docs/DEV_ENV.md) guide
- [ ] Work from the latest Candle Cookbook `git fetch upstream`
- [ ] Name your branch according to [creating your dev branch](#creating-your-dev-branch)
- [ ] Test and review changes/links according to [reviewing your changes](#reviewing-your-changes)


## Creating your dev branch

Your recipe branch should follow the format `<build-platform>-<prefix>-<desc>`

Where:
* `build-platform` is one of: 'aws', 'azure', 'local', 'global'
* `prefix` is one of: 
    * 'fix' -- for improvements to an existing recipe
    * 'new' -- for a new recipe
    * 'docs' -- for doc changes/additions
    * 'test' -- for workflow/unit test modifications/additions
    * 'refactor' -- for structural changes to project/repo
* `desc` is a meaningful identifier (such as recipe name) in kebab-case

```
git fetch upstream main
git checkout -b <build-platform>-<prefix>-<desc> -t upstream/main
```

## Improving a recipe

Recipe improvements can be:
* Semantic -- to improve the instruction clarity 
* Enhancements -- to improve the performance of the recipe
* Extensions -- to extend/add to the recipe capability

For extensions, consider if it is better suited as a new recipe that lists the existing recipe as a prerequisite step. For example, see how [Jenkins + CodePipeline](../src/aws/jenkins-pipeline.md) references and builds on the [Hello, Candle on AWS!](../src/aws/hello-aws.md) tutorial.


## Creating a recipe

NB: Your recipe name must be unique 

1. Copy the [recipe template](./templates/recipe.md) into the relevant build platform directory (i.e. aws, azure, local)
2. Rename as your kebab-case `recipe-name.md`.
3. Add your recipe and link to the relevant `build-platform/index.md` file

To include assets create a new folder `assets/source/<recipe-name>/`

Images must be in .png or .jpg format and added to `assets/source/<recipe-name>/`


## Reviewing your changes

Ensure Cookbook builds and test all hyperlinks

**Build Cookbook**

```
make cookbook
```

**Preview Cookbook at [localhost:8000](http://127.0.0.1:8000)**

```
make serve
# CTRL+C to close server
```

## Commiting your changes

```
git add .
git commit -m "<prefix> <desc>"
git push origin <build-platform>-<prefix>-<desc>
```

## Open a Pull Request

From your forked candle-cookbook repo >> Pull requests >> New pull request >> Select:

base repository: nogibjj/candle-cookbook, base: main <-- head repository: your-username/candle-cookbook, comapre: your-branch

You will be asked to complete the [Pull Request Checklist](../.github/pull_request_template.md)

**⚠️ IMPORTANT:** Once you have submitted a PR do not push any further changes. If you wish to edit -- delete the PR and submit a new one.

**❌ NEVER:** git push origin branch --force
