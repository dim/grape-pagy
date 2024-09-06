### 0.9.0

- Pin to Pagy 9.x.

Breaking changes based on [CHANGELOG.md](https://github.com/ddnexus/pagy/blob/master/CHANGELOG.md#version-900):
- BREAKING: Rename :max_limit > :limit_max
- BREAKING: Rename variable, param, accessor, extra and helper "items" to "limit"
- BREAKING: Transform the vars positional hash argument in keyword arguments (double splat); internal renaming of setup/assign methods
- Refactor pagy_get_vars in various backend extras
- BREAKING: Refactor the fragment url
- BREAKING: Refactor the anchor_string system
- BREAKING: Drop the support for 8+ deprecations

Possibly breaking overrides:

The internal **Pagy protected methods have been renamed and refactored**. If you use custom Pagy classes, you may need to search into the code.

### 0.5.0

- Pin to Pagy 5.x.

### 0.4.0

- Pin to Pagy 4.x.

### 0.3.1

- Pin to Pagy 3.x.

## 0.3.0

- Allow countless usage [#2](https://github.com/bsm/grape-pagy/pull/2).

## 0.2.0

- Improved, simplified and stabilised API [#1](https://github.com/bsm/grape-pagy/pull/1).

## 0.1.0

- Initial release.
