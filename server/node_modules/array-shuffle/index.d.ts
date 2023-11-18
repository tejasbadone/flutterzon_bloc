/**
Randomize the order of items in an array.

@param array - The array to shuffle.

@example
```
import arrayShuffle from 'array-shuffle';

const shuffled = arrayShuffle([1, 2, 3, 4, 5, 6]);
//=> [3, 5, 4, 1, 2, 6]
```
*/
export default function arrayShuffle<ElementType>(array: readonly ElementType[]): ElementType[];
