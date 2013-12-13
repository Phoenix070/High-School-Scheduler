import MySQLdb

####CHOOSING CLASSES####
def func1():
    conn = MySQLdb.connect (host = "localhost",
                           user = "root",
                           passwd = "pooja",
                           db = "project")
    cursor = conn.cursor ()
    cursor1 = conn.cursor ()
    cursor2 = conn.cursor ()
    cursor3 = conn.cursor ()
    for i in range(1,11):
        sql="SELECT cname,grade FROM STUD_CLASS where sid="+str(i)
        cursor.execute(sql)
        data=cursor.fetchall()

        sql2="SELECT gpa FROM STUDENT where sid="+str(i)
        cursor2.execute(sql2)
        row=cursor2.fetchone()
        gpa=float(row[0])
        print i
        for row in data:
            print "NEW-----"
            cname1=str(row[0])
            grade=str(row[1])
            sql1="SELECT cname,ctype FROM CLASSES where dependency='"+cname1+"'"
            
            cursor1.execute(sql1)
            data1=cursor1.fetchall()
            for row1 in data1:
                ctype=str(row1[1])
                if "advanced" in ctype.lower():
                    if gpa>3:
                        print row1[0]
                        print "Advanced : "
                        print row1[1]
                        sql3="INSERT INTO scheduled values("+str(i)+",\""+str(row1[0])+"\")"
                        cursor3.execute(sql3)
                        break
                else:
                    print row1[0]
                    print row1[1]
                    sql3="INSERT INTO scheduled values("+str(i)+",\""+str(row1[0])+"\")"
                    cursor3.execute(sql3)
                    break
                
    conn.commit()
    print "All done!"
    cursor.close ()
    cursor1.close()
    conn.close ()
