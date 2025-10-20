
## 2.1.0
- chore: bumped min dart version to `3.8.0`

## 2.0.0
- feat!: the `DataClass.updatable` field has been moved to the `DataParameter` annotation which must be applied to constructor fields
- feat: added the `Unspecified` class to support `null` as a parameter in the `copyWith` method
- refactor!: removed class visibility fields, now all `*Changes` and `*Builder` classes are public
- refactor!: removed support for `DataClass.createFieldsClass` as it is supported by the `json_serializable` package
- refactor!: renamed the `DataField.comparable` field to `DataField.comparable`


## 1.4.1
- fix: fixed Set equality allowing all keys

## 1.4.0
- feat: Added support for `*Builder`. You can now build your class via a Builder

## 1.3.0
- feat: support change `*Fields` class visibility by `DataClass.fieldsClassVisible` param

## 1.2.0
- chore: update `class_to_string` dependency to `1.0.0`

## 1.1.0
- feat: You can pass your `Equality` classes to `DataClass(equalities: [...])`
- chore: Added support for dart `3.0`

## 1.0.1
- chore: introduced new api for the generator package

## 1.0.0
- feat: `DataField.equality` to customize the equal operator and hashcode through the use of the Equality class

## 0.2.0
- Added `DataClass.createFieldsClass` to create a class that contains the names of the fields of the Data Class

## 0.1.0
- Removed `DeepCollectionEquality` export in favor of `DataClass.$equals` method

## 0.0.1+1
- Fix example documentation links

## 0.0.1
- Initial version.
