[TOC]



### 概述

首先链表可能是继数组之后第二种使用的最广泛的通用存储结构，它可以解决数组的一些缺陷，例如：无序数组搜索的低效、有序数组中插入的效率，以及数组创建后大小是不可改变的！

链表的机制灵活、用户广泛，适用于许多通用的数据库，在不需要频繁通过下标随机访问数据时，可以取代数组作为其他存储结构的基础。



### 链接点

![image-20200509195436305](all_images/image-20200509195436305.png)



### java基本类型与引用

Java基本类型的存储与引用类型的存储完全不同，基本数据类型int、double简单字段不是引用，而是实实在在的数值。
int a = 123;

在内存中创建了一个空间，并把数字123放入其中。

Link aLink =  someLink;

它把Link对象的引用someLink放到了变量aLink中。而someLink本身是在其他地方，通过上述赋值语句，它没有移动，仅仅是把内存指向赋值给了aLink。想要创建一个对象比如使用new关键字:

Link someLink = new Link();

someLink字段也没有真正意义上拥有一个对象；它仍然是个引用。这个对象在内存的某个地方，如下图：

![image-20200509200531530](all_images/image-20200509200531530.png)



### 链表与数组的区别

关系，而不是位置；

在数组中，每一项占用一个特定的位置，即下标，可以通过下标找到该项，类似于一排房子，你可以凭借地址找到房子。

而链表，需要一个特定元素就要按照这个链路一直走下去，直到找到为止，不能像数组一样直接访问到特定项。



### 单链表

```java
package linked_list;

// linkList2.java
// demonstrates linked list
// to run this program: C>java LinkList2App
////////////////////////////////////////////////////////////////
class Link {
    public int iData;              // data item (key)
    public double dData;           // data item
    public Link next;              // next link in list

    // -------------------------------------------------------------
    public Link(int id, double dd) // constructor
    {
        iData = id;
        dData = dd;
    }

    // -------------------------------------------------------------
    public void displayLink()      // display ourself
    {
        System.out.print("{" + iData + ", " + dData + "} ");
    }
}  // end class Link

////////////////////////////////////////////////////////////////
class LinkList {
    private Link first;            // ref to first link on list

    // -------------------------------------------------------------
    public LinkList()              // constructor
    {
        first = null;               // no links on list yet
    }

    // -------------------------------------------------------------
    public void insertFirst(int id, double dd) {                           // make new link
        Link newLink = new Link(id, dd);
        newLink.next = first;       // it points to old first link
        first = newLink;            // now first points to this
    }

    // -------------------------------------------------------------
    public Link find(int key)      // find link with given key
    {                           // (assumes non-empty list)
        Link current = first;              // start at 'first'
        while (current.iData != key)        // while no match,
        {
            if (current.next == null)        // if end of list,
            {
                return null;                 // didn't find it
            } else                            // not end of list,
            {
                current = current.next;      // go to next link
            }
        }
        return current;                    // found it
    }

    // -------------------------------------------------------------
    public Link delete(int key)    // delete link with given key
    {                           // (assumes non-empty list)
        Link current = first;              // search for link
        Link previous = first;
        while (current.iData != key) {
            if (current.next == null)
                return null;                 // didn't find it
            else {
                previous = current;          // go to next link
                current = current.next;
            }
        }                               // found it
        if (current == first)               // if first link,
            first = first.next;             //    change first
        else                               // otherwise,
            previous.next = current.next;   //    bypass it
        return current;
    }

    // -------------------------------------------------------------
    public void displayList()      // display the list
    {
        System.out.print("List (first-->last): ");
        Link current = first;       // start at beginning of list
        while (current != null)      // until end of list,
        {
            current.displayLink();   // print data
            current = current.next;  // move to next link
        }
        System.out.println("");
    }
// -------------------------------------------------------------
}  // end class LinkList

////////////////////////////////////////////////////////////////
class LinkList2App {
    public static void main(String[] args) {
        LinkList theList = new LinkList();  // make list

        theList.insertFirst(22, 2.99);      // insert 4 items
        theList.insertFirst(44, 4.99);
        theList.insertFirst(66, 6.99);
        theList.insertFirst(88, 8.99);

        theList.displayList();              // display list

        Link f = theList.find(44);          // find item
        if (f != null) {
            System.out.println("Found link with key " + f.iData);
        } else {
            System.out.println("Can't find link");
        }

        Link d = theList.delete(66);        // delete item
        if (d != null) {
            System.out.println("Deleted link with key " + d.iData);
        } else {
            System.out.println("Can't delete link");
        }

        theList.displayList();              // display list
    }  // end main()
}  // end class LinkList2App
////////////////////////////////////////////////////////////////

执行结果:
List (first-->last): {88, 8.99} {66, 6.99} {44, 4.99} {22, 2.99} 
Found link with key 44
Deleted link with key 66
List (first-->last): {88, 8.99} {44, 4.99} {22, 2.99} 
```



### 双端链表

双端链表对比单链表多了对最后一个链接点的引用，如下图:

![image-20200509201644685](all_images/image-20200509201644685.png)

单链表想在链表尾部插入一个链接点，需要遍历整个单链表而双端链表切好可以解决该问题，双端链表也可以解决像访问表头一样访问表尾数据的问题。



```java
package linked_list.first_last_list;

// firstLastList.java
// demonstrates list with first and last references
// to run this program: C>java FirstLastApp
////////////////////////////////////////////////////////////////
class Link {
    public long dData;                 // data item
    public Link next;                  // next link in list

    // -------------------------------------------------------------
    public Link(long d)                // constructor
    {
        dData = d;
    }

    // -------------------------------------------------------------
    public void displayLink()          // display this link
    {
        System.out.print(dData + " ");
    }
// -------------------------------------------------------------
}  // end class Link

////////////////////////////////////////////////////////////////
class FirstLastList {
    private Link first;               // ref to first link
    private Link last;                // ref to last link

    // -------------------------------------------------------------
    public FirstLastList()            // constructor
    {
        first = null;                  // no links on list yet
        last = null;
    }

    // -------------------------------------------------------------
    public boolean isEmpty()          // true if no links
    {
        return first == null;
    }

    // -------------------------------------------------------------
    public void insertFirst(long dd)  // insert at front of list
    {
        Link newLink = new Link(dd);   // make new link

        if (isEmpty())                // if empty list,
        {
            last = newLink;             // newLink <-- last
        }
        newLink.next = first;          // newLink --> old first
        first = newLink;               // first --> newLink
    }

    // -------------------------------------------------------------
    public void insertLast(long dd)   // insert at end of list
    {
        Link newLink = new Link(dd);   // make new link
        if (isEmpty())                // if empty list,
        {
            first = newLink;            // first --> newLink
        } else {
            last.next = newLink;        // old last --> newLink
        }
        last = newLink;                // newLink <-- last
    }

    // -------------------------------------------------------------
    public long deleteFirst()         // delete first link
    {                              // (assumes non-empty list)
        long temp = first.dData;
        if (first.next == null)         // if only one item
        {
            last = null;                // null <-- last
        }
        first = first.next;            // first --> old next
        return temp;
    }

    // -------------------------------------------------------------
    public void displayList() {
        System.out.print("List (first-->last): ");
        Link current = first;          // start at beginning
        while (current != null)         // until end of list,
        {
            current.displayLink();      // print data
            current = current.next;     // move to next link
        }
        System.out.println("");
    }
// -------------------------------------------------------------
}  // end class FirstLastList

////////////////////////////////////////////////////////////////
class FirstLastApp {
    public static void main(String[] args) {                              // make a new list
        FirstLastList theList = new FirstLastList();

        theList.insertFirst(22);       // insert at front
        theList.insertFirst(44);
        theList.insertFirst(66);

        theList.insertLast(11);        // insert at rear
        theList.insertLast(33);
        theList.insertLast(55);

        theList.displayList();         // display the list

        theList.deleteFirst();         // delete first two items
        theList.deleteFirst();

        theList.displayList();         // display again
    }  // end main()
}  // end class FirstLastApp
////////////////////////////////////////////////////////////////
执行结果：
List (first-->last): 66 44 22 11 33 55 
List (first-->last): 22 11 33 55 
```



#### 效率

表头插入和删除的很快，仅需修改一两个引用值，O(1)的时间。

查找、删除和在指定链接点后插入都需要平均搜索一半的链表，需要O(N)次比较。数组在执行这些操作时也需要O(N)次比较，但是链表仍然要快一些，因为插入和删除链接点时不需要像数组一样需要移动其余项。

链表比数组优越的另外一点为链表需要多少内存就使用多少内存并且可以扩展到所有可用内存。数组的大小在创建时就已经定下了，太大导致效率低下，太小容易内存溢出。



### 有序链表

链表中的链接点数据按照关键值有序排列，有序链表的删除通常只限于删除链表头部的最大或最小链接点。



```java
package linked_list.sort_list;

// sortedList.java
// demonstrates sorted list
// to run this program: C>java SortedListApp
////////////////////////////////////////////////////////////////
class Link {
    public long dData;                  // data item
    public Link next;                   // next link in list

    // -------------------------------------------------------------
    public Link(long dd)                // constructor
    {
        dData = dd;
    }

    // -------------------------------------------------------------
    public void displayLink()           // display this link
    {
        System.out.print(dData + " ");
    }
}  // end class Link

////////////////////////////////////////////////////////////////
class SortedList {
    private Link first;                 // ref to first item

    // -------------------------------------------------------------
    public SortedList()                 // constructor
    {
        first = null;
    }

    // -------------------------------------------------------------
    public boolean isEmpty()            // true if no links
    {
        return (first == null);
    }

    // -------------------------------------------------------------
    public void insert(long key)        // insert, in order
    {
        Link newLink = new Link(key);    // make new link
        Link previous = null;            // start at first
        Link current = first;
        // until end of list,
        while (current != null && key > current.dData) {                             // or key > current,
            previous = current;
            current = current.next;       // go to next item
        }
        if (previous == null)               // at beginning of list
        {
            first = newLink;              // first --> newLink
        } else                             // not at beginning
        {
            previous.next = newLink;      // old prev --> newLink
        }
        newLink.next = current;          // newLink --> old currnt
    }  // end insert()

    // -------------------------------------------------------------
    public Link remove()           // return & delete first link
    {                           // (assumes non-empty list)
        Link temp = first;               // save first
        first = first.next;              // delete first
        return temp;                     // return value
    }

    // -------------------------------------------------------------
    public void displayList() {
        System.out.print("List (first-->last): ");
        Link current = first;       // start at beginning of list
        while (current != null)      // until end of list,
        {
            current.displayLink();   // print data
            current = current.next;  // move to next link
        }
        System.out.println("");
    }
}  // end class SortedList

////////////////////////////////////////////////////////////////
class SortedListApp {
    public static void main(String[] args) {                            // create new list
        SortedList theSortedList = new SortedList();
        theSortedList.insert(20);    // insert 2 items
        theSortedList.insert(40);

        theSortedList.displayList(); // display list

        theSortedList.insert(10);    // insert 3 more items
        theSortedList.insert(30);
        theSortedList.insert(50);

        theSortedList.displayList(); // display list

        theSortedList.remove();      // remove an item

        theSortedList.displayList(); // display list
    }  // end main()
}  // end class SortedListApp
////////////////////////////////////////////////////////////////
执行结果：
List (first-->last): 20 40 
List (first-->last): 10 20 30 40 50 
List (first-->last): 20 30 40 50 
```



#### 效率

插入和删除某一项，最多需要O(N)次比较（平均N/2）,然后删除最大或最小值的时间为O(1)，因为它总在表头。如果一个应用频繁的读取最大OR最小值，且不需要快速插入，可以用有序链表，例如：优先级队列。

也可以做插入排序，效率比数组的插入排序更高。



### 双向链表

以上链表方式都只能从前往后遍历数据，无法做到从后往前遍历数据。

![image-20200509205015689](all_images/image-20200509205015689.png)



缺点：

每次插入和删除一个链接点时需要处理4个链接点的引用关系，由于多了2个引用，链接点的空间占用也变大了一点。



```java
package double_link;

// doublyLinked.java
// demonstrates doubly-linked list
// to run this program: C>java DoublyLinkedApp
////////////////////////////////////////////////////////////////
class Link {
    public long dData;                 // data item
    public Link next;                  // next link in list
    public Link previous;              // previous link in list

    // -------------------------------------------------------------
    public Link(long d)                // constructor
    {
        dData = d;
    }

    // -------------------------------------------------------------
    public void displayLink()          // display this link
    {
        System.out.print(dData + " ");
    }
// -------------------------------------------------------------
}  // end class Link

////////////////////////////////////////////////////////////////
class DoublyLinkedList {
    private Link first;               // ref to first item
    private Link last;                // ref to last item

    // -------------------------------------------------------------
    public DoublyLinkedList()         // constructor
    {
        first = null;                  // no items on list yet
        last = null;
    }

    // -------------------------------------------------------------
    public boolean isEmpty()          // true if no links
    {
        return first == null;
    }

    // -------------------------------------------------------------
    public void insertFirst(long dd)  // insert at front of list
    {
        Link newLink = new Link(dd);   // make new link

        if (isEmpty())                // if empty list,
        {
            last = newLink;             // newLink <-- last
        } else {
            first.previous = newLink;   // newLink <-- old first
        }
        newLink.next = first;          // newLink --> old first
        first = newLink;               // first --> newLink
    }

    // -------------------------------------------------------------
    public void insertLast(long dd)   // insert at end of list
    {
        Link newLink = new Link(dd);   // make new link
        if (isEmpty())                // if empty list,
        {
            first = newLink;            // first --> newLink
        } else {
            last.next = newLink;        // old last --> newLink
            newLink.previous = last;    // old last <-- newLink
        }
        last = newLink;                // newLink <-- last
    }

    // -------------------------------------------------------------
    public Link deleteFirst()         // delete first link
    {                              // (assumes non-empty list)
        Link temp = first;
        if (first.next == null)         // if only one item
        {
            last = null;                // null <-- last
        } else {
            first.next.previous = null; // null <-- old next
        }
        first = first.next;            // first --> old next
        return temp;
    }

    // -------------------------------------------------------------
    public Link deleteLast()          // delete last link
    {                              // (assumes non-empty list)
        Link temp = last;
        if (first.next == null)         // if only one item
        {
            first = null;               // first --> null
        } else {
            last.previous.next = null;  // old previous --> null
        }
        last = last.previous;          // old previous <-- last
        return temp;
    }

    // -------------------------------------------------------------
    // insert dd just after key
    public boolean insertAfter(long key, long dd) {                              // (assumes non-empty list)
        Link current = first;          // start at beginning
        while (current.dData != key)    // until match is found,
        {
            current = current.next;     // move to next link
            if (current == null) {
                return false;            // didn't find it
            }
        }
        Link newLink = new Link(dd);   // make new link

        if (current == last)              // if last link,
        {
            newLink.next = null;        // newLink --> null
            last = newLink;             // newLink <-- last
        } else                           // not last link,
        {
            newLink.next = current.next; // newLink --> old next
            // newLink <-- old next
            current.next.previous = newLink;
        }
        newLink.previous = current;    // old current <-- newLink
        current.next = newLink;        // old current --> newLink
        return true;                   // found it, did insertion
    }

    // -------------------------------------------------------------
    public Link deleteKey(long key)   // delete item w/ given key
    {                              // (assumes non-empty list)
        Link current = first;          // start at beginning
        while (current.dData != key)    // until match is found,
        {
            current = current.next;     // move to next link
            if (current == null) {
                return null;             // didn't find it
            }
        }
        if (current == first)             // found it; first item?
        {
            first = current.next;       // first --> old next
        } else                           // not first
            // old previous --> old next
        {
            current.previous.next = current.next;
        }

        if (current == last)              // last item?
        {
            last = current.previous;    // old previous <-- last
        } else                           // not last
            // old previous <-- old next
        {
            current.next.previous = current.previous;
        }
        return current;                // return value
    }

    // -------------------------------------------------------------
    public void displayForward() {
        System.out.print("List (first-->last): ");
        Link current = first;          // start at beginning
        while (current != null)         // until end of list,
        {
            current.displayLink();      // display data
            current = current.next;     // move to next link
        }
        System.out.println("");
    }

    // -------------------------------------------------------------
    public void displayBackward() {
        System.out.print("List (last-->first): ");
        Link current = last;           // start at end
        while (current != null)         // until start of list,
        {
            current.displayLink();      // display data
            current = current.previous; // move to previous link
        }
        System.out.println("");
    }
// -------------------------------------------------------------
}  // end class DoublyLinkedList

////////////////////////////////////////////////////////////////
class DoublyLinkedApp {
    public static void main(String[] args) {                             // make a new list
        DoublyLinkedList theList = new DoublyLinkedList();

        theList.insertFirst(22);      // insert at front
        theList.insertFirst(44);
        theList.insertFirst(66);

        theList.insertLast(11);       // insert at rear
        theList.insertLast(33);
        theList.insertLast(55);

        theList.displayForward();     // display list forward
        theList.displayBackward();    // display list backward

        theList.deleteFirst();        // delete first item
        theList.deleteLast();         // delete last item
        theList.deleteKey(11);        // delete item with key 11

        theList.displayForward();     // display list forward

        theList.insertAfter(22, 77);  // insert 77 after 22
        theList.insertAfter(33, 88);  // insert 88 after 33

        theList.displayForward();     // display list forward
    }  // end main()
}  // end class DoublyLinkedApp
////////////////////////////////////////////////////////////////
执行结果:
List (first-->last): 66 44 22 11 33 55 
List (last-->first): 55 33 11 22 44 66 
List (first-->last): 44 22 33 
List (first-->last): 44 22 77 33 88 
```



双向链表经常用来作为双端队列和迭代器的数据存储。



![image-20200509210131658](all_images/image-20200509210131658.png)

