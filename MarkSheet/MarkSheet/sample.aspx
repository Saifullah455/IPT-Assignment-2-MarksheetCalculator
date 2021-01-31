﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sample.aspx.cs" Inherits="MarkSheet.sample" %>

<!DOCTYPE html>
 <html>

<head>
    <title>Markssheet</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        .customButton {
            border: 1px solid gray;
            padding: 2px 6px 2px 6px;
            cursor: pointer;
        }

        .customButton:hover {
            border: 1px solid black;
            box-shadow: gray 2px 2px 5px;
        }
    </style>
</head>

<body>
    <h1>Marksheet</h1>
    <div>
        <table>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>
                                <span>Enter the name of student :</span>
                            </td>
                            <td>
                                <input type="text" id="nameOfStudent" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>Enter the number of subjects : </span>
                            </td>
                            <td>
                                <input type="number" id="noOfSubjects" min="1" onchange="UIPopulate()"
                                    onkeyup="UIPopulate()" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <span onclick="Calculate()" class="customButton">Calculate</span>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td>
                                <span>Min Marks Subject: </span>
                            </td>
                            <td>
                                <input type="text" id="minMarksSubject" readonly="readonly" />
                            </td>
                            <td>
                                <span>Min Marks: </span>
                            </td>
                            <td>
                                <input type="text" id="minMarks" readonly="readonly" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>Max Marks Subject: </span>
                            </td>
                            <td>
                                <input type="text" id="maxMarksSubject" readonly="readonly" />
                            </td>
                            <td>
                                <span>Max Marks: </span>
                            </td>
                            <td>
                                <input type="text" id="maxMarks" readonly="readonly" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>Percentage : </span>
                            </td>
                            <td>
                                <input type="text" id="percentage" readonly="readonly" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <hr />
    <div>
        <table id="inputTable">
        </table>
    </div>
</body>
<script>

    function Calculate() {
        //YOUR CODE GOES HERE
        var noOfSubjects = $('#noOfSubjects').val();
        var subjectList = [];
        for(i = 0; i < noOfSubjects; i++) {
            var subjectDetails = new Object();
            subjectDetails.subject = $('#subjectName' + i).val();
            subjectDetails.marks = $('#subjectMarksObtained' + i).val();
            subjectList.push(subjectDetails);
        }
        var subjectStr = JSON.stringify(subjectList);
        $.ajax({
            type: "GET",
            url: "sample.aspx/StudentDetails",
            contentType: "application/JSON",
            data: {
                "request" : subjectStr,
            },
            success: function(result){
                displayData(result.d)
            },
        });
    }

    function displayData(result) {
        var obj = JSON.parse(result);
        $('#minMarks').val(obj.miniMarks);
        $('#maxMarks').val(obj.maxiMarks);
        $('#minMarksSubject').val(obj.miniMarksSubject);
        $('#maxMarksSubject').val(obj.maxiMarksSubject);
        $('#percentage').val(obj.per + "%");
    }

    function UIPopulate() {
        var noOfSubjects = $('#noOfSubjects').val();

        var h = '';
        for (i = 0; i < noOfSubjects; i++) {
            h += '<tr>';

            h += '<td>';
            h += '<span>Subject ' + (i + 1) + ' -> </span>';
            h += '</td>';

            h += '<td>';
            h += '<span>Name :</span>';
            h += '</td>';

            h += '<td>';
            h += '<input type="text" id="subjectName' + i + '"/>';
            h += '</td>';

            h += '<td>';
            h += '<span>Marks Obtained :</span>';
            h += '</td>';

            h += '<td>';
            h += '<input type="number" min="0" max="100" id="subjectMarksObtained' + i + '"/>';
            h += '</td>';

            h += '</tr>';
        }

        $('#inputTable').html(h);
    }
</script>
</html>