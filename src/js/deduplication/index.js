
/**
 * Deduplication by using filter and indexOf method.
 * @param {Array} dupPrimitiveList - Arrary(only contains primitive values) that gonna to be deduplicated.
 * @returns {Array} -Array that been deduplicated.
 */
function deduplication_1(dupPrimitiveList) {
    return dupPrimitiveList.filter((el, i, arr) => arr.indexOf(el) === i)
}


/**
 * Deduplication by using ES6 Set.
 * @param {Array} dupPrimitiveList - Arrary(only contains primitive values) that gonna to be deduplicated.
 * @returns {Array} -Array that been deduplicated.
 */
function deduplication_2(dupPrimitiveList) {
    return Array.from(new Set(dupPrimitiveList))
}