# github-script-ruby

This action makes it easy to write Ruby scripts in the workflow, just like [actions/github-script](https://github.com/actions/github-script).

In order to use this action, a `script` input is provided. The value of that input should be the body of an function call. The following arguments will be provided:

- `github` A pre-authenticated [octokit.rb](https://github.com/octokit/octokit.rb) client with `auto_paginate=true`
- `context` An OpenStruct instance containing the context of the workflow run
- `core` An instance of [GitHub::Actions::Toolkit::Core](lib/github/actions/toolkit/core.rb)

## Examples

### Print the available attributes of context

ref: [actions/github-script example](https://github.com/actions/github-script#print-the-available-attributes-of-context)

``` yaml
- name: View context attributes
  uses: k1LoW/github-script-ruby@main
  with:
    script: pp context
```
### Comment on an issue

ref: [actions/github-script example](https://github.com/actions/github-script#comment-on-an-issue)

``` yaml
on:
  issues:
    types: [opened]

jobs:
  comment:
    runs-on: ubuntu-latest
    steps:
      - uses: k1LoW/github-script-ruby@main
        with:
          script: |
            repo = "#{context.repo.owner}/#{context.repo.repo}"
            number = context.issue.number
            comment = '👋 Thanks for reporting!'
            github.add_comment(repo, number, comment)
```

## References

- [actions/github-script](https://github.com/actions/github-script): Write workflows scripting the GitHub API in JavaScript