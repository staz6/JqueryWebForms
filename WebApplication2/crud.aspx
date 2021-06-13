<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="crud.aspx.cs" Inherits="WebApplication2.crud" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous" />
<link href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css" rel="stylesheet" />
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

    <div class="container">

        <form runat="server" id="form1" onsubmit="return JQueryAjaxPost(this)">
            <div class="mb-3">
                <input class="form-control" id="Id" type="hidden"  aria-describedby="Id" />
            </div>
            <div class="mb-3">
                <label for="exampleInputName" class="form-label">Name</label>
                <input class="form-control" id="Name" aria-describedby="Name" />
                <div id="emailHelp" class="form-text">Enter your full name.</div>
            </div>
            <button type="submit" id="formsubmit" class="btn btn-primary">Submit</button>
        </form>



        <button class="btn btn-info" >Get Values</button>
        <table class="table" id="personTable">
            <thead>
                <tr>
                    <th scope="col">Id</th>
                    <th scope="col">Name</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>

            </tbody>

        </table>
    </div>
</body>
</html>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="//cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
<script type="text/javascript">

    $(document).ready(function () {
        getOs();
        changeBtnText();

        $("#personTable").on("click",".js-delete",function () {
            console.log("delete button");
            if (confirm("Are you sure you want to delete the selected record")) {
                value = $(this).attr("delete-person-id");
                $.ajax({
                    type: "post",
                    url: "crud.aspx/DeleteCustomer",
                    data: '{id: "' + value + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function () {
                        getOs();
                    }
                })
            }
        })

        $("#personTable").on("click", ".js-edit", function () {
            console.log("Edit Button")
            var id = $(this).closest('tr').find('.id').text();
            var name = $(this).closest('tr').find('.name').text();
            //assign above variables text1,text2 values to other elements.
            $("#Id").val(id);
            $("#Name").val(name);
            $("#Name").focus();
            changeBtnText();
        })
       
        
    });
    JQueryAjaxPost = form => {
        Id = $("#Id").val();
        console.log(Id);
        Name = $("#Name").val();
        if (Id == 0 || Id == "" || Id == null) {
            $.ajax({
                type: "post",
                url: "crud.aspx/PostCustomer",
                data: '{Name: "' + Name + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () {
                    $("#Name").val("");
                    changeBtnText();
                    getOs();
                }
            })
        }
        else {
            $.ajax({
                type: "post",
                url: "crud.aspx/EditCustomer",
                data: '{Id:"'+Id+'",Name: "' + Name + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () {
                    $("#Id").val("");
                    $("#Name").val("");
                    changeBtnText();
                    getOs();
                }
            })
        }
        
        return false;
    }
    function getOs() {
        $.ajax({
            type: 'Get',
            url: "crud.aspx/GetCustomers",
            contentType: "application/json",
            success: function (response) {
                console.log(response.d[1].Name)
                $("#personTable > tbody").empty();
                for (var i = 0; i < response.d.length; i++) {
                    $("#personTable > tbody").append("<tr><td class='id'>" + response.d[i].Id + "</td><td class='name'>" + response.d[i].Name + "</td><td>"
                        + " <button class='btn btn-info js-edit' data-person-id=" + response.d[i].Id + "  >Edit</button>  <button class= 'btn btn-danger js-delete'  delete-person-id=" + response.d[i].Id + " > Delete</button ></td >   </tr > ")
                }
            }
        });
    }

    function changeBtnText() {
        idval = $("#Name").val();
        if (idval != "") {
            $("#formsubmit").html("Save")
        }
        else {
            $("#formsubmit").html("Submit")
        }
    }
  

    
</script>

