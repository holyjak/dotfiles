# See https://github.com/Yelp/detect-secrets/blob/master/docs/filters.md#using-your-own-filters
def not_deps_git_sha(filename: str, line: str, secret: str) -> bool:
    return (filename.endswith("deps.edn") and ":sha" in line)

