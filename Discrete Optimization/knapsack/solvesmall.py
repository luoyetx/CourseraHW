from collections import namedtuple
Item = namedtuple("Item", ['index', 'value', 'weight'])

def solve_it(input_data):
    # Modify this code to run your optimization algorithm

    # parse the input
    lines = input_data.split('\n')

    firstLine = lines[0].split()
    item_count = int(firstLine[0])
    capacity = int(firstLine[1])

    items = []

    for i in range(1, item_count+1):
        line = lines[i]
        parts = line.split()
        items.append(Item(i-1, int(parts[0]), int(parts[1])))

    # a trivial greedy algorithm for filling the knapsack
    # it takes items in-order until the knapsack is full
    value = 0
    weight = 0
    taken = [0]*len(items)

    O = [[0 for i in xrange(item_count+1)] for j in xrange(capacity+1)]
    for index, value, weight in items:
        for k in xrange(capacity+1):
            if (k < weight):
                O[k][index] = O[k][index-1]
            else: O[k][index] = max(O[k][index-1], O[k-weight][index-1]+value)
    value = O[capacity][index]
    
    k = capacity
    for index, _, weight in items[::-1]:
        if (O[k][index] == O[k][index-1]):
            taken[index] = 0
        else:
            taken[index] = 1
            #print index, value
            k -= weight
    # prepare the solution in the specified output format
    output_data = str(value) + ' ' + str(1) + '\n'
    output_data += ' '.join(map(str, taken))
    return output_data
