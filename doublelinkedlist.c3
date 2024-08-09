module linkedlist;
import std::io;
import std::core::mem;

struct Node 
{ 
    int value;
    Node* next_node;
    Node* previous_node;
}

fn Node* createNode(int value)
{ 
    Node* head_node = mem::new(Node, {.value = value, .next_node = null,
    .previous_node = null});
    return head_node;
}

fn void Node.append(Node* this, int value)
{
    Node* new_node = createNode(value); 
    new_node.previous_node = this;
    this.next_node = new_node; 
}

fn void Node.free(Node* this)
{
    free(this);
}

struct DoubleLinkedList 
{
    Node* node;
}

fn void DoubleLinkedList.freeNodes(DoubleLinkedList* this)
{
    while(this.node)
    { 
        Node* nxt = this.node.next_node;
        this.node.free();
        this.node = nxt;
    }
}

fn void DoubleLinkedList.printInvert(DoubleLinkedList* this)
{
    Node* last_node;
    while(this.node)
    {
        last_node = this.node;
        this.node = this.node.next_node;
    }

    while(last_node)
    {
	    io::printf("%d\n", last_node.value);
        last_node = last_node.previous_node;
    }
}

fn void DoubleLinkedList.print(DoubleLinkedList* this)
{ 
    while(this.node)
    { 
	    io::printf("%d\n", this.node.value);
        this.node = this.node.next_node;
    }
}

fn int main(String[] args)
{
    Node* head_node = createNode(1);
    head_node.append(2);
    DoubleLinkedList* ll = mem::new(DoubleLinkedList, { .node = head_node});
    defer ll.freeNodes();
    ll.printInvert();


	return 0;
}
