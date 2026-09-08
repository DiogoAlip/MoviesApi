export const isObjectEmpty = (obj) => {
  for (const prop in obj) {
    if (Object.hasOwn(obj, prop)) {
      return false; // Found a property, so it's not empty
    }
  }
  return true;
};
