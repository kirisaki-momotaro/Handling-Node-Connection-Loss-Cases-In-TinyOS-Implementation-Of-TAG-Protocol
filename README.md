# Handling Node Connection Loss Cases In TinyOS Implementation Of TAG Protocol


## HOW TO RUN:

1. cd to the tinyOS folder:
```cd /home/tinyos/local/src/tinyos-2x/apps/tinyOS```

2. Run make 
```make micaz sim```

3. Create topology file where D the node grid's width and height and RANGE the range of each node
```python ./topology_creator.py D RANGE```

4. Run the simulation entering as parameter the total number of nodes (NUMBER_OF_NODES) also equal to D^2
```python ./mySimulation.py NUMBER_OF_NODES```

