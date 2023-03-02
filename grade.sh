CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -f ListExamples.*
git clone $1 student-submission
echo 'Finished cloning'
cd student-submission
if [[ -e ListExamples.java ]]
    then
        echo "ListExamples found"
    else 
        echo "Error: ListExamples not found"
        exit 1
    fi
cp ListExamples.java ..
cd ..
set +e
javac -cp $CPATH *.java
javac ListExamples.java
if [[ $? -ne 0 ]]
then
    echo "Error: Compile Error"
else
    java -cp $CPATH org.junit.runner.JUnitCore TestListExamples | grep -i "Test" > idk.txt
    result=($(wc -w < idk.txt))
    if [[ $result == 3 ]]
    then
        echo "All tests passed"
    else
        cat idk.txt
    fi

fi