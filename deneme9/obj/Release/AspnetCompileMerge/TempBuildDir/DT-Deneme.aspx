<%@ Page Language="C#" AutoEventWireup="false" CodeBehind="DT-Deneme.aspx.cs" Inherits="deneme9.DT_Deneme" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <title></title>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.5/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.5/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.5/js/buttons.print.min.js"></script>




    <link href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.datatables.net/buttons/1.6.5/css/buttons.dataTables.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            
            var tableBody1 = [
                [
                    {
                        text: 'first column',
                        fillColor: '#555555',
                        color: '#00FFFF',
                    },
                    {
                        text: 'second column',
                        color: '#555555',
                        fillColor: '#dedede'
                    },
                    {
                        text: 'third column',
                        fillColor: '#555555'
                    },
                    {
                        text: 'third column',
                        fillColor: '#555555'
                    }
                ],

                [
                    { text: 'Bold value', bold: true }, 'Val 2', 'Val 3', 'Val 4'

                ],
                ['First', 'Second', 'Third', 'The last one'],
                ['Value 1', 'Value 2', 'Value 3', 'Value 4'],
                [{ text: 'Bold value', bold: true }, 'Val 2', 'Val 3', 'Val 4']
            ];
            var tableBody2 = [
                [
                    {
                        text: 'first column',
                        fillColor: '#555555',
                        color: '#00FFFF',
                    },
                    {
                        text: 'second column',
                        color: '#555555',
                        fillColor: '#dedede'
                    },
                    {
                        text: 'third column',
                        fillColor: '#555555'
                    },
                    {
                        text: 'third column',
                        fillColor: '#555555'
                    }
                ],

                [{ text: 'Bold value', bold: true }, 'Val 2', 'Val 3', 'Val 4'],
                ['First', 'Second', 'Third', 'The last one'],
                ['Value 1', 'Value 2', 'Value 3', 'Value 4'],
                [{ text: 'Bold value', bold: true }, 'Val 2', 'Val 3', 'Val 4']
            ];


            var deneme = ['table 1:', {
                style: 'tableExample', table: {
                    body: tableBody1
                }
            }]

            var dd = {
                header: {
                    text: 'Table cells with fillColor support',
                    fontSize: 16,
                    alignment: 'center',
                    margin: [72, 40]
                },
                content: [

                    'Table 1:',
                    {
                        style: 'tableExample',
                        table: {

                            headerRows: 1,
                            widths: ['*', 'auto', 100, '*'],
                            body: tableBody1
                        }
                    },
                    'Table 2:',
                    {
                        style: 'tableExample',
                        table: {
                            headerRows: 1,
                            widths: ['*', 'auto', 100, '*'],
                            body: tableBody2
                        }
                    },
                ],
                styles: {
                    header: {
                        fontSize: 14,
                        bold: true
                    },
                    cell: {
                        color: 'red',
                        fillColor: 'yellow'
                    }
                },
                pageMargins: [72, 100, 72, 40]
            }

            // download the PDF
            pdfMake.createPdf(dd).download();
        });
    </script>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />


</head>
<body>
    <form id="form1" runat="server">
        <table id="example1" class="display">
        <thead>
             <tr>
                <th>Name</th>
                <th>Position</th>
                <th>Office</th>
                <th>Age</th>
                <th>date</th>
                <th>Salary</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>David Konrad</td>
                <td>System Architect</td>
                <td>Copenhagen</td>
                <td>+40</td>
                <td>2017/11/17</td>
                <td>$320,800</td>
            </tr>
            <tr>
                <td>Colleen Hurst</td>
                <td>Javascript Developer</td>
                <td>San Francisco</td>
                <td>39</td>
                <td>2009/09/15</td>
                <td>$205,500</td>
            </tr>

  </tbody>
    </table>  
    
         <table id="example2" class="display">
        <thead>
             <tr>
                <th>Name</th>
                <th>Position</th>
                <th>Office</th>
                <th>Age</th>
                <th>date</th>
                <th>Salary</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>David Konrad</td>
                <td>System Architect</td>
                <td>Copenhagen</td>
                <td>+40</td>
                <td>2017/11/17</td>
                <td>$320,800</td>
            </tr>
            <tr>
                <td>Colleen Hurst</td>
                <td>Javascript Developer</td>
                <td>San Francisco</td>
                <td>39</td>
                <td>2009/09/15</td>
                <td>$205,500</td>
            </tr>

  </tbody>

    </table>   
       
    </form>
</body>
</html>
