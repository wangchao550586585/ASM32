;使用构造和REPEAT创建链表
INCLUDE Irvine32.inc

ListNode STRUCT
	NodeData DWORD ?
	NextPtr  DWORD ?
ListNode ENDS

TotalNodeCount=15
NULL=0
Counter=0

.data
LinkedList LABEL PTR listNode
REPEAT TotalNodeCount
	Counter=Counter+1
	ListNode <Counter,($ + Counter * SIZEOF ListNode)>
ENDM
ListNode<0,0>			;尾节点

.code
main PROC
	mov esi,OFFSET LinkedList

NextNode:
	mov eax,(ListNode PTR [esi]).NextPtr
	cmp eax,NULL
	je  quit
	mov eax,(ListNode PTR [esi]).NodeData
	call WriteDec
	call Crlf
	
	mov esi,(ListNode PTR [esi]).NextPtr
	jmp NextNode
quit:
	exit
main ENDP
END main
