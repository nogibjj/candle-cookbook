# ⚙️ Developer Setup

**Fork Project**

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo#forking-a-repository) the [Candle Cookbook repo](https://github.com/nogibjj/candle-cookbook/tree/main) to your GitHub account.

**Create Developer Environment**

Configure a [Codespace](https://docs.github.com/en/codespaces/developing-in-codespaces/creating-a-codespace-for-a-repository) or clone locally

```
git clone https://github.com/nogibjj/candle-cookbook
```

**Add Upstream Remote**

```
git remote add upstream https://github.com/nogibjj/candle-cookbook.git
git fetch upstream main
```

**Install Cookbook**

```
make install
```

**Build Cookbook**

```
make cookbook
```

**Preview Cookbook at [localhost:8000](http://127.0.0.1:8000)**

```
make serve
# CTRL+C to close server
```