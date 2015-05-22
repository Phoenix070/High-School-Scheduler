import MySQLdb

####GPA FUNCTION####
def func2():
    conn = MySQLdb.connect (host = "localhost",
                           user = "root",
                           passwd = "pooja",
                           db = "project")
    cursor = conn.cursor ()
    cursor1 = conn.cursor ()
    cursor2 = conn.cursor ()
    for i in range(1,11):
        units=0
        sum1=0
        gpa=0
        print i
        sql1="SELECT cname,grade FROM STUD_CLASS where sid="+str(i)
        cursor1.execute(sql1)
        data1=cursor1.fetchall()
        for row1 in data1:
            sql="SELECT units FROM CLASSES where cname='"+str(row1[0])+"'"
            cursor.execute(sql)
            row=cursor.fetchone()
            unitrow=row[0]
            print unitrow
            if row1[1]=='A':
                sum1+=4*unitrow
            if row1[1]=='B':
                sum1+=3*unitrow
            if row1[1]=='C':
                sum1+=2*unitrow
            units+=unitrow
        print sum1
        print units
        gpa=float(sum1)/units
        print gpa
        sql2="UPDATE STUDENT SET gpa="+str(gpa)+"where sid="+str(i)
        cursor2.execute(sql2)
        print "------------"
    conn.commit()
    
    cursor.close()
    cursor1.close()
    cursor2.close()
    conn.close ()
