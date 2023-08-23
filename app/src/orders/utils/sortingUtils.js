export const compareValues = (valueA, valueB) => {
  if (typeof valueA === "string" && typeof valueB === "string") {
    return valueA.localeCompare(valueB);
  }
  return valueA - valueB;
};

export const getColumnValue = (item, column) => {
  if (column === "ordered_at" || column === "pick_up_at") {
    return new Date(item[column]);
  }
  return item[column];
};
