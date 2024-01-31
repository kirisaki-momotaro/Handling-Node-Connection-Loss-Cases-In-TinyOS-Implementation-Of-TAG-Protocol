import sys ,os , math

range_duplicates=[]

def generate_grid(D):
    grid = [[0 for _ in range(D)] for _ in range(D)]
    element =0
    for i in range(D**2):
        y=i/D
        x=i%D
        print(x,y)
        grid[x][y] = i
        
    return grid

def get_nodes_in_range(x,y,R,grid):
    nodes_in_range = []
    for i in range(D):        
        for j in range(D):            
            if(i!=x and j!=y):
                dist=distance(x,y,i,j)
                if(dist<R):      
                    if((grid[x][y],grid[i][j]) not in range_duplicates):    
                        nodes_in_range.append(grid[i][j])
                        range_duplicates.append((grid[i][j],grid[x][y]))

            
    return nodes_in_range

def distance(x,y,x1,y1):
    distance = math.sqrt((x - x1)**2 + (y - y1)**2)
    return distance


## python topology_creator.py D range
print 'Number of arguments:', len(sys.argv), 'arguments.'
print 'Argument List:', str(sys.argv[1])

if len(sys.argv)!=3:
    print "wrong parameters"
    


#read input parameters
D=int(sys.argv[1])
R=float(sys.argv[2])
if os.path.exists("topology_generated.txt"):
  os.remove("topology_generated.txt")
f = open("topology_generated.txt","a")
grid=generate_grid(D)


for x in range(D):
        for y in range(D): 
            #print(x, y)
            nodes_in_range_list = get_nodes_in_range(x,y,R,grid)       
            for node in nodes_in_range_list:
                string_to_write = str(grid[x][y]) + " " + str(node) + " -50.0\n" + str(node) + " " + str(grid[x][y]) + " -50.0\n\n"
                f.write(string_to_write)              
f.close()


