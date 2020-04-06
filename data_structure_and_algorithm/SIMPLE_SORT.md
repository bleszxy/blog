**冒泡排序**

运行速度比较慢，但是在概念上是排序算法中最简单的。



从第一项，与所有项进行比较，进行最少0次最多N-1次交换，然后从第二项开始，重复第一项做的事情，直到所有项大概进行了(N-1)+(N-2)+(N-3)+...+1=N(N-1)/2次比较后排序成功。如下图：



![image-20200406181921547](./images/image-20200406181921547.png)



示例代码：

```
package simplesort;

// bubbleSort.java
// demonstrates bubble sort
// to run this program: C>java BubbleSortApp
////////////////////////////////////////////////////////////////
class ArrayBub {
    private long[] a;                 // ref to array a
    private int nElems;               // number of data items

    //--------------------------------------------------------------
    public ArrayBub(int max)          // constructor
    {
        a = new long[max];                 // create the array
        nElems = 0;                        // no items yet
    }

    //--------------------------------------------------------------
    public void insert(long value)    // put element into array
    {
        a[nElems] = value;             // insert it
        nElems++;                      // increment size
    }

    //--------------------------------------------------------------
    public void display()             // displays array contents
    {
        for (int j = 0; j < nElems; j++)       // for each element,
        {
            System.out.print(a[j] + " ");  // display it
        }
        System.out.println("");
    }

    //--------------------------------------------------------------
    public void bubbleSort() {
        int out, in;

        for (out = nElems - 1; out > 1; out--)   // outer loop (backward)
        {
            for (in = 0; in < out; in++)        // inner loop (forward)
            {
                if (a[in] > a[in + 1])       // out of order?
                {
                    swap(in, in + 1);          // swap them
                }
            }
        }
    }  // end bubbleSort()

    //--------------------------------------------------------------
    private void swap(int one, int two) {
        long temp = a[one];
        a[one] = a[two];
        a[two] = temp;
    }
//--------------------------------------------------------------
}  // end class ArrayBub

////////////////////////////////////////////////////////////////
class BubbleSortApp {
    public static void main(String[] args) {
        int maxSize = 100;            // array size
        ArrayBub arr;                 // reference to array
        arr = new ArrayBub(maxSize);  // create the array

        arr.insert(77);               // insert 10 items
        arr.insert(99);
        arr.insert(44);
        arr.insert(55);
        arr.insert(22);
        arr.insert(88);
        arr.insert(11);
        arr.insert(00);
        arr.insert(66);
        arr.insert(33);

        arr.display();                // display items

        arr.bubbleSort();             // bubble sort them

        arr.display();                // display them again
    }  // end main()
}  // end class BubbleSortApp
////////////////////////////////////////////////////////////////

执行结果：
77 99 44 55 22 88 11 0 66 33 
arr elem len:10 loop out:9 in:1 a[in]:99 > a[in + 1]:44 swap!
arr elem len:10 loop out:9 in:2 a[in]:99 > a[in + 1]:55 swap!
arr elem len:10 loop out:9 in:3 a[in]:99 > a[in + 1]:22 swap!
arr elem len:10 loop out:9 in:4 a[in]:99 > a[in + 1]:88 swap!
arr elem len:10 loop out:9 in:5 a[in]:99 > a[in + 1]:11 swap!
arr elem len:10 loop out:9 in:6 a[in]:99 > a[in + 1]:0 swap!
arr elem len:10 loop out:9 in:7 a[in]:99 > a[in + 1]:66 swap!
arr elem len:10 loop out:9 in:8 a[in]:99 > a[in + 1]:33 swap!
77 44 55 22 88 11 0 66 33 99 
arr elem len:10 loop out:8 in:0 a[in]:77 > a[in + 1]:44 swap!
arr elem len:10 loop out:8 in:1 a[in]:77 > a[in + 1]:55 swap!
arr elem len:10 loop out:8 in:2 a[in]:77 > a[in + 1]:22 swap!
arr elem len:10 loop out:8 in:4 a[in]:88 > a[in + 1]:11 swap!
arr elem len:10 loop out:8 in:5 a[in]:88 > a[in + 1]:0 swap!
arr elem len:10 loop out:8 in:6 a[in]:88 > a[in + 1]:66 swap!
arr elem len:10 loop out:8 in:7 a[in]:88 > a[in + 1]:33 swap!
44 55 22 77 11 0 66 33 88 99 
arr elem len:10 loop out:7 in:1 a[in]:55 > a[in + 1]:22 swap!
arr elem len:10 loop out:7 in:3 a[in]:77 > a[in + 1]:11 swap!
arr elem len:10 loop out:7 in:4 a[in]:77 > a[in + 1]:0 swap!
arr elem len:10 loop out:7 in:5 a[in]:77 > a[in + 1]:66 swap!
arr elem len:10 loop out:7 in:6 a[in]:77 > a[in + 1]:33 swap!
44 22 55 11 0 66 33 77 88 99 
arr elem len:10 loop out:6 in:0 a[in]:44 > a[in + 1]:22 swap!
arr elem len:10 loop out:6 in:2 a[in]:55 > a[in + 1]:11 swap!
arr elem len:10 loop out:6 in:3 a[in]:55 > a[in + 1]:0 swap!
arr elem len:10 loop out:6 in:5 a[in]:66 > a[in + 1]:33 swap!
22 44 11 0 55 33 66 77 88 99 
arr elem len:10 loop out:5 in:1 a[in]:44 > a[in + 1]:11 swap!
arr elem len:10 loop out:5 in:2 a[in]:44 > a[in + 1]:0 swap!
arr elem len:10 loop out:5 in:4 a[in]:55 > a[in + 1]:33 swap!
22 11 0 44 33 55 66 77 88 99 
arr elem len:10 loop out:4 in:0 a[in]:22 > a[in + 1]:11 swap!
arr elem len:10 loop out:4 in:1 a[in]:22 > a[in + 1]:0 swap!
arr elem len:10 loop out:4 in:3 a[in]:44 > a[in + 1]:33 swap!
11 0 22 33 44 55 66 77 88 99 
arr elem len:10 loop out:3 in:0 a[in]:11 > a[in + 1]:0 swap!
0 11 22 33 44 55 66 77 88 99 
0 11 22 33 44 55 66 77 88 99 
```



**选择排序**

选择排序改进了冒泡排序，将必要的交换次数从O(N²)减少至O(N)，不幸的是比较次数仍保持为O(N²)。

简述

​       进行选择排序就是把所有的队员扫描一遍，从中挑出（或者说选择，这正是这个排序名字的由来）最矮的一个队员。最矮的队员和站在队列最左端的队员交换位置，即站在0号位置。现在最左端的队员是有序的了，不需要再交换位置了。

​       再次扫描球队队员时，就从1号位置开始，还是寻找最矮的，然后和1号位置的队员交换。这个过程一直持续到所有队员都排定。



![image-20200406184110821](./images/image-20200406184110821.png)

```
package simplesort;

// selectSort.java
// demonstrates selection sort
// to run this program: C>java SelectSortApp
////////////////////////////////////////////////////////////////
class ArraySel {
    private long[] a;                 // ref to array a
    private int nElems;               // number of data items

    //--------------------------------------------------------------
    public ArraySel(int max)          // constructor
    {
        a = new long[max];                 // create the array
        nElems = 0;                        // no items yet
    }

    //--------------------------------------------------------------
    public void insert(long value)    // put element into array
    {
        a[nElems] = value;             // insert it
        nElems++;                      // increment size
    }

    //--------------------------------------------------------------
    public void display()             // displays array contents
    {
        for (int j = 0; j < nElems; j++)       // for each element,
        {
            System.out.print(a[j] + " ");  // display it
        }
        System.out.println("");
    }

    //--------------------------------------------------------------
    public void selectionSort() {
        int out, in, min;

        for (out = 0; out < nElems - 1; out++)   // outer loop
        {
            min = out;                     // minimum
            for (in = out + 1; in < nElems; in++) // inner loop
            {
                if (a[in] < a[min])         // if min greater,
                {
                    min = in;               // we have a new min
                }
            }
            System.out.println("arr elem len:" + nElems + " loop out:" + out + " select min:" + a[min] + " swap " + a[out] + "!");
            swap(out, min);                // swap them
            display();
        }  // end for(out)
    }  // end selectionSort()

    //--------------------------------------------------------------
    private void swap(int one, int two) {
        long temp = a[one];
        a[one] = a[two];
        a[two] = temp;
    }
//--------------------------------------------------------------
}  // end class ArraySel

////////////////////////////////////////////////////////////////
class SelectSortApp {
    public static void main(String[] args) {
        int maxSize = 100;            // array size
        ArraySel arr;                 // reference to array
        arr = new ArraySel(maxSize);  // create the array

        arr.insert(77);               // insert 10 items
        arr.insert(99);
        arr.insert(44);
        arr.insert(55);
        arr.insert(22);
        arr.insert(88);
        arr.insert(11);
        arr.insert(00);
        arr.insert(66);
        arr.insert(33);

        arr.display();                // display items

        arr.selectionSort();          // selection-sort them
    }  // end main()
}  // end class SelectSortApp
////////////////////////////////////////////////////////////////

执行结果：
77 99 44 55 22 88 11 0 66 33 
arr elem len:10 loop out:0 select min:0 swap 77!
0 99 44 55 22 88 11 77 66 33 
arr elem len:10 loop out:1 select min:11 swap 99!
0 11 44 55 22 88 99 77 66 33 
arr elem len:10 loop out:2 select min:22 swap 44!
0 11 22 55 44 88 99 77 66 33 
arr elem len:10 loop out:3 select min:33 swap 55!
0 11 22 33 44 88 99 77 66 55 
arr elem len:10 loop out:4 select min:44 swap 44!
0 11 22 33 44 88 99 77 66 55 
arr elem len:10 loop out:5 select min:55 swap 88!
0 11 22 33 44 55 99 77 66 88 
arr elem len:10 loop out:6 select min:66 swap 99!
0 11 22 33 44 55 66 77 99 88 
arr elem len:10 loop out:7 select min:77 swap 77!
0 11 22 33 44 55 66 77 99 88 
arr elem len:10 loop out:8 select min:88 swap 99!
0 11 22 33 44 55 66 77 88 99 


```

