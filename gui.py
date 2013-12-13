#####GUI#####

#!/usr/bin/python
import MySQLdb
import Tkinter
from Tkinter import *

root = Tk()
RTitle=root.title("Phoenix High School")
root.minsize(800, 800)
root.maxsize(900, 900)
text = Text(root)
def func1():
   conn = MySQLdb.connect (host = "localhost",
                           user = "root",
                           passwd = "pooja",
                           db = "project")
   cursor = conn.cursor ()
   cursor1 = conn.cursor ()
   cursor2 = conn.cursor ()
   cursor3 = conn.cursor ()
   i=E1.get()
   sql1="select fname,lname from student where sid="+str(i)
   cursor1.execute(sql1)
   row1=cursor1.fetchone()
   text.insert(END, "\nStudent Name:")
   text.insert(END, row1[0])
   text.insert(END, " ")
   text.insert(END, row1[1])
   text.insert(END, "\n\nStudent ID:")
   text.insert(END, i)
   text.insert(END,"\n\nTime Table:\n")

   day='None'
   if str(var.get())=='1':
      day='Monday'
   elif str(var.get())=='2':
      day="Tuesday"
   elif str(var.get())=='3':
      day="Wednesday"
   elif str(var.get())=='4':
      day="Thursday"
   else:
      day="Friday"
      
   sql2="select period, hour_from, hour_to from timing where weekday='"+str(day)+"'"
   cursor2.execute(sql2)
   data2=cursor2.fetchall()

   text.insert(END,"\n---")
   text.insert(END,str(day))
   text.insert(END,"---\n")
   text.insert(END,"Period\t\tTiming\t\tClass Name\n")
   for row2 in data2:
      text.insert(END, "\n")
      text.insert(END, str(row2[0]))
      text.insert(END, "\t\t")
      text.insert(END, str(row2[1]))
      text.insert(END, " - ")
      text.insert(END, str(row2[2]))
      text.insert(END, "\t\t")
      
      sql="select scheduled.cname, ctype from scheduled join classes on scheduled.cname=classes.cname where sid="+str(i)
      cursor.execute(sql)
      data=cursor.fetchall()
      sql3="select class from class_timing where period="+str(row2[0])
      cursor3.execute(sql3)
      row3=cursor3.fetchone()
      for row in data:
         ctyp=str(row3[0])
         if ctyp in str(row[1]):
            text.insert(END, row[0])
      if str(row2[0])=='7':
         text.insert(END, "Gym")
      text.pack()
      text.place(height=400,width=500, x=10, y=250)

   return


L1 = Label(root, text="Student ID")
L1.pack( side = LEFT)
L1.place(height=30, width=100,x=10,y=10)
E1 = Entry(root,bd =5)
E1.pack(side = RIGHT)
E1.place(height=30, width=100, x=100, y=10)

var = IntVar()
R1 = Radiobutton(root, text="Monday",variable=var, value=1)
R1.pack()
R1.place(height=30, width=80, x=20, y=50)
R2 = Radiobutton(root, text="Tuesday",variable=var, value=2)
R2.pack()
R2.place(height=30, width=80, x=20, y=70)
R3 = Radiobutton(root, text="Wednesday",variable=var, value=3)
R3.pack()
R3.place(height=30, width=100, x=20, y=90)
R2 = Radiobutton(root, text="Thursday",variable=var, value=4)
R2.pack()
R2.place(height=30, width=80, x=24, y=110)
R3 = Radiobutton(root, text="Friday ",variable=var, value=5)
R3.pack()
R3.place(height=30, width=80, x=20, y=130)

B = Button(root, text ="Submit", command =func1)
B.pack()
B.place(height=30, width=100, x=30, y=200)
root.mainloop()

