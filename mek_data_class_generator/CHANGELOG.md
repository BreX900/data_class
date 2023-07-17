## 1.5.1
- fix: Fixes prefer_final_locals lint on hashcode method
- chore: Update analyzer dependency

## 1.5.0
- feat: Added support for `*Builder`. You can now build your class via a Builder

## 1.4.0
- feat: support change `*Fields` class visibility by `DataClass.fieldsClassVisible` param
- fix: suppress `unused_element` lint when `*Fields` class is private

## 1.3.1
- fix: private fields class generation

## 1.3.0
- fix: unnecessary parentheses on `toString` method [#20](https://github.com/BreX900/data_class/issues/20)
- fix: `Classes and mixins can only implement other classes and mixins` error [#19](https://github.com/BreX900/data_class/issues/19)
- feat: `toString` method now print `null` values [#17](https://github.com/BreX900/data_class/issues/17), you can change this behavior by setting the yaml file `stringify_if_null: false`

## 1.2.0

- feat: You can pass your `Equality` classes to `DataClass(equalities: [...])`
- chore: Added support for dart `3.0`

## 1.1.1
- fix: hashcode generation
- perf: New hashCode and == operator generation, have better performance. [#12](https://github.com/BreX900/data_class/issues/12)

## 1.1.0
- feat: allow positional parameters on data class constructors
- refactor: improve code style using code_builder package

## 1.0.2
- fix: bug when annotated classes also use mixins

## 1.0.1
- fix: InconsistentAnalysisException

## 1.0.0
- feat: customization of the equal operator and hashcode through the use of the Equality class
- feat: namespace support (prefix imports): `library.Product`
- feat: Can define on the yaml file whether the toString method should include all fields of the class 
    or only the parameters of the constructor

**BREAKING CHANGES**:
- refactor: use snake_case in yaml file

## 0.4.0
- fix: generate a `copyWith` and `*Changes` with not updatable parameters
- fix: generate a `copyWith` and `*Changes` with parameters that do not exist in the constructors
- feat: Added `json_serializable` support for creating the `*Fields` class. Now if the given class has 
  `@JsonSerializable(createFieldMap: true)` it will read its map values.

**BREAKING CHANGES**:
- refactor: removed method `*Changes.replace`. You can directly assign the value and then call change.
  Instead of: `order.change((c) => c.product.change((c) => c..replace(product)..title = 'New Title'))`.
  Uses: `order.change((c) => c.product = product.change((c) => c..title = 'New Title'))`

## 0.3.1
- feat: support analyzer `>=4.0.0 <6.0.0`

## 0.3.0
- feat: Added support for type aliases (typedef)

## 0.2.0
- Added `DataClass.createFieldsClass` to create a class that contains the names of the fields of the Data Class

## 0.1.4
- fix generation for fields on abstract class

## 0.1.3
- feat update analyzer dependency

## 0.1.1
- Fix nested null type when generating `copyWith` method

## 0.1.0
- Fix `hashcode` method generation
- Removed `@override` annotation to reduce generated code
- Now the `_props` method is an iterable to improve performance

## 0.0.3+1
- Fix example documentation links

## 0.0.3
- Expose `update` method in `*Changes` class to update a class with function
- Expose `replace` method to update `*Changes` class with all DataClass properties

## 0.0.1
- Initial version.
