[TOC]

#### 简介

递归是一种方法(函数)调用自己的编程技术。

#### **特性**

1. 调用自身

2. 当它调用自身时，是为了坚决更小的问题。

3. 存在某个足够简单的问题的层次，在这一层算法不需要调用自己就可以直接解答，且返回结果。

#### **二分查找**

```
有序数组二分查找
package recursive.binary_search.simple;

class ordArray {
    private long[] a;                 // ref to array a
    private int nElems;               // number of data items

    //-----------------------------------------------------------
    public ordArray(int max)          // constructor
    {
        a = new long[max];             // create array
        nElems = 0;
    }

    //-----------------------------------------------------------
    public int size() {
        return nElems;
    }

    //-----------------------------------------------------------
    public int find(long searchKey) {
        int lowerBound = 0;
        int upperBound = nElems - 1;
        int curIn;
        while (true) {
            curIn = (lowerBound + upperBound) / 2;
            if (a[curIn] == searchKey) {
                return curIn; //found it
            } else if (lowerBound > upperBound) {
                return nElems; // can't found it
            } else {
                if (a[curIn] < searchKey) {
                    lowerBound = curIn + 1; //it's in upper half
                } else {
                    upperBound = curIn - 1; //it's in lower half
                }
            }
        }
    }


    //-----------------------------------------------------------
    public void insert(long value)    // put element into array
    {
        int j;
        for (j = 0; j < nElems; j++)        // find where it goes
        {
            if (a[j] > value)            // (linear search)
            {
                break;
            }
        }
        // move bigger ones up
        if (nElems - j >= 0) {
            System.arraycopy(a, j, a, j + 1, nElems - j);
        }
        a[j] = value;                  // insert it
        nElems++;                      // increment size
    }  // end insert()

    //-----------------------------------------------------------
    public void display()             // displays array contents
    {
        for (int j = 0; j < nElems; j++)       // for each element,
        {
            System.out.print(a[j] + " ");  // display it
        }
        System.out.println("");
    }
    //-----------------------------------------------------------
}  // end class ordArray

////////////////////////////////////////////////////////////////

class BinarySearchApp {
    public static void main(String[] args) {
        int maxSize = 100;             // array size
        ordArray arr;                  // reference to array
        arr = new ordArray(maxSize);   // create the array

        arr.insert(72);                // insert items
        arr.insert(90);
        arr.insert(45);
        arr.insert(126);
        arr.insert(54);
        arr.insert(99);
        arr.insert(144);
        arr.insert(27);
        arr.insert(135);
        arr.insert(81);
        arr.insert(18);
        arr.insert(108);
        arr.insert(9);
        arr.insert(117);
        arr.insert(63);
        arr.insert(36);

        arr.display();                 // display array

        int searchKey = 27;            // search for item
        if (arr.find(searchKey) != arr.size()) {
            System.out.println("Found " + searchKey);
        } else {
            System.out.println("Can't find " + searchKey);
        }
    }  // end main()
}  // end class BinarySearchApp
////////////////////////////////////////////////////////////////

执行结果如下：
9 18 27 36 45 54 63 72 81 90 99 108 117 126 135 144 
Found 27


基于递归的二分查找
对比上面while的方式，仅仅是find方法的改变，添加了recFind，封装了自我调用的逻辑。
 //-----------------------------------------------------------
    public int find(long searchKey) {
        return recFind(searchKey, 0, nElems - 1);
    }

    //-----------------------------------------------------------
    private int recFind(long searchKey, int lowerBound,
                        int upperBound) {
        int curIn;

        curIn = (lowerBound + upperBound) / 2;
        if (a[curIn] == searchKey) {
            return curIn;              // found it
        } else if (lowerBound > upperBound) {
            return nElems;             // can't find it
        } else                          // divide range
        {
            if (a[curIn] < searchKey)   // it's in upper half
            {
                return recFind(searchKey, curIn + 1, upperBound);
            } else                       // it's in lower half
            {
                return recFind(searchKey, lowerBound, curIn - 1);
            }
        }  // end else divide range
    }  // end recFind()

recfind()方法反复的自我调用，每一次调用都比上一次的范围更小，当在最内层的方法找到了指定数据项后，这个值依次从每一层的recfind()中返回。
```



递归的二分查找与非递归的二分查找有着同样的大O效率:O(logN)。递归的二分查找更为简洁一些，但是它的速度可能会慢一点。

PS:人们常常使用递归并非其本质上更有效率，而是可以从概念上简化问题。



#### **分治算法**

递归的二分查找法是分治算法的一个例子。把一个大问题分成两个相对来说更小的问题，并且分别解决每一个小问题。对每个小问题的解决方法是一致的：把每个小问题分成两个更小的问题，并且解决他们。这个过程一直持续下去直到达到易于求解的基值情况，就不用再继续分了。

分治算法常常是一个方法，在这个方法中有两个对自身的递归调用，分别对应问题的两个部分。如上二分查找中就有两个这样的调用，但是只有一个真正执行了。PS：归并排序是一个典型的例子。

