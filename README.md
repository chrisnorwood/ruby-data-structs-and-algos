# Data Structures and Algorithms in Ruby

## Table of Contents:
- [About](#about)
- [Data Structures](#data-structures)
  - [Linked Lists](#linked-lists)
    - [Singly Linked List](#singly-linked-list)
    - [Doubly Linked List](#doubly-linked-list)
  - [Stack](#stack)
  - [Queue](#queue)
  - [Priority Queues/Heaps](#priority-queues)
    - [Min PQ with a Binary Heap](#min-pq-with-binary-heap)

## About
This repository contains a collection of common data structures and algorithms implemented in Ruby. It is a work-in-progress. The public APIs that these expose can be found in the following sections.

# Data Structures

## Linked Lists

### Singly Linked List

[*View Source Code Here*](linked-lists/singly_linked_list.rb)

### Doubly Linked List

[*View Source Code Here*](linked-lists/doubly_linked_list.rb)


Both linked-lists expose the same API.

Available methods:

```ruby
LinkedList.new

LinkedList.size

LinkedList.empty?

LinkedList.add(element)

LinkedList.add_last

LinkedList.add_first

LinkedList.remove_first

LinkedList.remove_last

LinkedList.peek_first

LinkedList.peek_last

LinkedList.peek_last

LinkedList.remove_at(index)

LinkedList.index_of(element)

LinkedList.contains?(element)

LinkedList.to_s

LinkedList.each(&block)


# the Enumerable module is included in each, and as such, LinkedList can use all
# methods available for Enumerable objects.
```

## Stack
[*View Source Code Here*](stacks/stack.rb)

This stack is implemented with the doubly linked list also found in this repository.

Available methods:

```ruby
# initial_value optional
Stack.new(initial_value)

Stack.size

Stack.empty?

Stack.push(element)

Stack.pop

Stack.each(&block)


# the Enumerable module is included, and as such, Stack can use all
# methods available for Enumerable objects.

```

## Queue
[*View Source Code Here*](queues/queue.rb)

This queue is implemented with the doubly linked list also found in this repository.

Available methods:

```ruby
# initial_value optional
Queue.new(initial_value)

Queue.size

Queue.empty?

Queue.offer(element)

Queue.peek

Queue.each(&block)


# the Enumerable module is included, and as such, Queue can use all methods 
# available for Enumerable objects.
```

## Priority Queues
### Min PQ with Binary Heap

[*View Source Code Here*](priority-queues-heaps/binary_heap.rb)

This is a min. priority queue, implemented as a Binary Heap.  All values must be of comparable and of the same type.

Available methods:

```ruby
# initial_elements_array optional
BinaryHeap.new(initial_elements_array)

BinaryHeap.size

BinaryHeap.empty?

BinaryHeap.poll

BinaryHeap.peek

BinaryHeap.add(value)

BinaryHeap.remove_at(index)

BinaryHeap.remove(value)

BinaryHeap.contains?(value)

BinaryHeap.clear
```