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
  - [Union Find](#union-find)

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

LinkedList.add_first

LinkedList.add_last

LinkedList.remove_first

LinkedList.remove_last

LinkedList.peek_first

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

Queue.poll

Queue.peek

Queue.each(&block)


# the Enumerable module is included, and as such, Queue can use all methods 
# available for Enumerable objects.
```

## Priority Queues
### Min PQ with Binary Heap

[*View Source Code Here*](priority-queues-heaps/binary_heap.rb)

This is a min. priority queue, implemented as a Binary Heap.  All values should be comparable and of the same type. This implementation uses a hash table, storing heap item values as keys to their indices to support O(log n) removals.

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

## Union Find

[*View Source Code Here*](union-find/union_find.rb)

This is a union find implementation, that includes path compression for greater time-efficiency.

The current implementation is not based on any particular type of nodes/elements. Rather it identifies nodes by 'number', sequentially from `0 -> initial_size - 1`. Groups are identified by their root element's "number".

Available methods:

```ruby
UnionFind.new(integer_size)

# Finds the group node_id belongs to
UnionFind.find(node_id)

UnionFind.unify(node_id_1, node_id_2)

UnionFind.connected?(node_id_1, node_id_2)

UnionFind.group_size(node_id)
```