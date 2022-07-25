# Ordering

Ordering works consistently with the `<`, `<=`, `>`, `>=` operators. Some comparisons involving `()` and `float:NaN` are considered unordered. The `order by` clause allows expressions. A library module can enable unicode-aware sorting by providing a `unicode:sortKey(str, locale)` function.

::: code ordering.bal :::

::: out ordering.out :::