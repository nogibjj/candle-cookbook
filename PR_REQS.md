# ✅ Pull Request Requirements

- [ ] Review and adhere to our [Contributing Guidelines](./CONTRIBUTING.md) and [Code of Conduct](./CODE_OF_CONDUCT.md)
- [ ] Install Candle Cookbook according to the [Developer Setup](./DEV_ENV.md) guide
- [ ] Ensure you've got the latest update `git fetch upstream`
- [ ] Create your recipe branch `git checkout -b <build-platform>-<recipe-name> -t upstream/main`
- [ ] For new recipes: start from the [recipe template](./recipe.md)
- [ ] For new recipes: add your recipe to the relevant `source/index.md` file
- [ ] For pull requests: follow the [PR Requirements](PR_REQS.md)
- [ ] Images must be in .png or .jpg format and added to `assets/source/<recipe-name>/`

<hr>

## Create your recipe branch

Your recipe branch should follow the format `<build-platform>-<recipe-name>`.

Build platform is one of `aws`, `azure`, `local`

```
git fetch upstream
git checkout -b <build-platform>-<recipe-name> -t upstream/main
```

## Adding assets

To add assets create a new folder `assets/source/<recipe-name>/`

Images must be in .png or .jpg format and added to `assets/source/<recipe-name>/`

## Improving a Recipe

## Creating a Recipe


