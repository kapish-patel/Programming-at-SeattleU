# Author Kapish Patel
# this file contains programs for trees data structure


# tree traversal intuition using stack
def stack_intuition(root):
    # creating a stack to keep track of all the elements from top down as stack help in keeping vertical flow 

    #magic spell for traversal is 
    # 1. push root
    # 2. pop top
    # 3. push unvisited of top in stack
    stack = []

    stack.insert(0, root) #1. push root
    print("Pushed root:", stack[0].value)

    while stack:
        
        current = stack.pop() #2. pop top
        print("popped top:", current.value)

        # check if the current have child or not 
        if current.left or current.right:

            #3. push unvisited of top in stack
            if current.left:
                stack.insert(0, current.left)
                print("Pushed unvisited left:", current.left.value)

            if current.right:
                stack.insert(0, current.right)
                print("Pushed unvisited right:", current.right.value)

# inorder traversal left -> root -> right    
def inorder_traversal(root):
    print("InOrder traversal.....")
    
    # recursive function
    def r_DFS(root):
        # BASE case
        if not root:
            return 

        # RECURSIVE case
        if root.left:
            r_DFS(root.left)

        print(root.value)
        
        if root.right:
            r_DFS(root.right)

    r_DFS(root)

# pre order traversal root -> left -> right
def preorder_traversal(root):
    print("preOrder traversal.....")

    #recursive fucntion
    def r_DFS(root):
        #BASE case
        if not root:
            return
        
        print(root.value)
        
        #RECURSIVE case
        if root.left:
            r_DFS(root.left)
        
        if root.right:
            r_DFS(root.right)
    
    r_DFS(root)

# post order traversal left -> right -> root
def postOrder_traversal(root):
    print("postOrder traversal.....")

    #recursive function
    def r_DFS(root):
        #BASE case
        if not root:
            return
        
        #RECURSIVE case
        if root.left:
            r_DFS(root.left)
        
        if root.right:
            r_DFS(root.right)
        
        print(root.value)
    
    r_DFS(root)


#=============
# Driver code
#=============
class TreeNode:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

#create small tree
def create_small_tree():
    """
    Creates a simple binary tree and returns the root.
    """
    # Tree structure:
    #                     1
    #                  /     \
    #                 2       3
    #                / \     / \
    #               4   5   6   7
    root = TreeNode(1)
    root.left = TreeNode(2)
    root.right = TreeNode(3)
    root.left.left = TreeNode(4)
    root.left.right = TreeNode(5)
    root.right.left = TreeNode(6)
    root.right.right = TreeNode(7)

    return root

# create big tree
def create_big_tree():
    """
    Creates a simple binary tree and returns the root.
    """
    # Tree structure:
    #                     1
    #                  /     \
    #                 2       3
    #                / \     / \
    #               4   5   6   7
    #              / \
    #             8   9
    #            / \
    #           10 11
    #              /
    #             12
    #            /  \
    #           13  14
    #              /
    #             15
    root = TreeNode(1)
    root.left = TreeNode(2)
    root.right = TreeNode(3)
    root.left.left = TreeNode(4)
    root.left.right = TreeNode(5)
    root.right.left = TreeNode(6)
    root.right.right = TreeNode(7)
    root.left.left.left = TreeNode(8)
    root.left.left.right = TreeNode(9)
    root.left.left.left.left = TreeNode(10)
    root.left.left.left.right = TreeNode(11)
    root.left.left.left.right.left = TreeNode(12)
    root.left.left.left.right.left.left = TreeNode(13)
    root.left.left.left.right.left.right = TreeNode(14)
    root.left.left.left.right.left.right.left = TreeNode(15)

    return root

#main function call all the function here
def main():
    small_tree_root = create_small_tree()
    big_tree_root = create_big_tree()
    #stack_intuition(small_tree_root)
    inorder_traversal(small_tree_root)
    preorder_traversal(small_tree_root)
    postOrder_traversal(small_tree_root)

if __name__ == "__main__":
    # Create a sample tree
    main()
    