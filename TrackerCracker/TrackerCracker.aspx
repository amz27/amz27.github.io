<%@ Page Language="C#" ValidateRequest="false" AutoEventWireup="true" CodeBehind="TrackerCracker.aspx.cs" Inherits="TrackerCracker.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Captorra Tracker Cracker</title>

    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.0.0.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <style type="text/css">
        .container {
            max-width: 1000px;
            background-color: #eee;
            padding: 50px 30px 10px 30px;
            border: 1px solid #dfdfdf;
            border-radius: 5px 5px;
        }

        .header {
            overflow:auto;
            margin-left: 18%;
        }

        .header img{
            width: 100px;
            height: auto;
            float:left;
        }

        .header h1{
            float:left;
            margin-top: 55px;
        }

        .row {
            margin: 0 auto;
            margin-bottom: 10px;
        }

        .txt-label {
            text-align: right;
        }

        .mybtn {
            width: 5em
        }

        .bg-error {
            color: Red;
        }
    </style>


</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header">
                <div>
                    <img class="logo" src="./Content/src/cap-logo.png" border="0" />
                    <h1>Captorra Tracker Cracker</h1>
                </div>
            </div>
            <hr />

            <%-- PASSWORD GENERATOR SECTION --%>
            <div class="row">
                <div class="col align-self-start">
                    <strong>Password Generator</strong>
                </div>
            </div>

            <div class="row">
                <div class="col txt-label">
                    Password Length:
                </div>
                <div class="col-8">
                    <asp:DropDownList ID="PwLength" runat="server" CssClass="form-control" Width="200px">
                        <asp:ListItem Selected="True" Value="8"> 8 </asp:ListItem>
                        <asp:ListItem Value="16"> 16 </asp:ListItem>
                        <asp:ListItem Value="32"> 32 </asp:ListItem>
                        <asp:ListItem Value="40"> 40 </asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="row">
                <div class="col txt-label">
                    Include Numbers:
                </div>
                <div class="col-8">
                    <asp:CheckBox ID="IncludeNum" runat="server" Checked="true" />
                    <asp:Label ID="IncludeNumLabel" runat="server" class="form-check-label" Text="(e.g. 1234567890)"></asp:Label>
                </div>
            </div>

            <div class="row">
                <div class="col txt-label">
                    Include Lowercase Characters:
                </div>
                <div class="col-8">
                    <asp:CheckBox ID="IncludeLowercaseChar" runat="server" Checked="true" />
                    <asp:Label ID="IncludeLowercaseCharLabel" runat="server" class="form-check-label" Text="(e.g. abcdefgh)"></asp:Label>
                </div>
            </div>

            <div class="row">
                <div class="col txt-label">
                    Include Uppercase Characters:
                </div>
                <div class="col-8">
                    <asp:CheckBox ID="IncludeUppercaseChar" runat="server" Checked="true" />
                    <asp:Label ID="IncludeUppercaseCharLabel" runat="server" class="form-check-label" Text=" (e.g. ABCDEFGH)"></asp:Label>
                </div>
            </div>

            <div class="row">
                <div class="col txt-label">
                    Include Symbols:
                </div>
                <div class="col-8">
                    <asp:CheckBox ID="IncludeSymbols" runat="server" Checked="true" />
                    <asp:Label ID="IncludeSymbolsLabel" runat="server" class="form-check-label" Text="(e.g. !@$?_-)"></asp:Label>
                </div>
            </div>

            <div class="row">
                <div class="col txt-label">
                    Quantity:
                </div>
                <div class="col-8">
                    <asp:DropDownList ID="PwQuality" runat="server" CssClass="form-control" Width="200px">
                        <asp:ListItem Selected="True" Value="1"> 1 </asp:ListItem>
                        <asp:ListItem Value="2"> 2 </asp:ListItem>
                        <asp:ListItem Value="3"> 3 </asp:ListItem>
                        <asp:ListItem Value="4"> 4 </asp:ListItem>
                        <asp:ListItem Value="5"> 5 </asp:ListItem>
                        <asp:ListItem Value="6"> 6 </asp:ListItem>
                        <asp:ListItem Value="7"> 7 </asp:ListItem>
                        <asp:ListItem Value="8"> 8 </asp:ListItem>
                        <asp:ListItem Value="9"> 9 </asp:ListItem>
                        <asp:ListItem Value="10"> 10 </asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="row">
                <div class="col">
                </div>
                <div class="col-8">
                    <asp:Button ID="PasswordGenBtn" class="btn btn-primary" runat="server" Text="Generate Passwords" OnClick="PasswordGenBtn_Click" />
                </div>
            </div>

            <div class="row">
                <div class="col txt-label">
                    Passwords:
                </div>
                <div class="col-8">
                    <textarea id="PasswordArea" runat="server" cols="40" rows="10" class="form-control" style="width: 100% !important;"></textarea>
                    <asp:Button class="btn btn-primary mybtn" ID="PwCopyBtn" runat="server" Text="Copy" Style="margin-top: 5px" OnClick="PwCopyBtn_Click" />
                    <asp:Button class="btn btn-primary mybtn" ID="PwClearBtn" runat="server" Text="Clear" Style="margin: 5px 0 0 5px" OnClick="PwClearBtn_Click" />
                </div>


            </div>

            <%-- ENCODER/ DECODER SECTION --%>
            <div class="row">
                <div class="col align-self-start">
                    <strong>Base64 Encoder/Decoder</strong>
                </div>
            </div>

            <div class="row">
                <div class="col txt-label">
                    Input String:
                </div>
                <div class="col-8">
                    <asp:TextBox ID="input" runat="server" TextMode="MultiLine" Columns="40" Rows="10" class="form-control" Style="width: 100% !important;"></asp:TextBox>
                    <asp:Label ID="inputError" CssClass="bg-error" runat="server" Visible="false"></asp:Label>
                </div>
            </div>

            <div class="row">
                <div class="col">
                </div>
                <div class="col-8">
                    <asp:Button class="btn btn-primary mybtn" ID="EncryptBtn" runat="server" Text="Encrypt" OnClick="EncryptBtn_Click" />
                    <asp:Button class="btn btn-primary mybtn" ID="DecryptBtn" runat="server" Text="Decrypt" OnClick="DecryptBtn_Click" />
                </div>
            </div>

            <div class="row">
                <div class="col txt-label">
                    Result:
                </div>
                <div class="col-8">
                    <asp:TextBox ID="result" runat="server" TextMode="MultiLine" Columns="40" Rows="10" class="form-control" Style="width: 100% !important;"></asp:TextBox>
                    <asp:Label ID="lblMessage" CssClass="bg-error" runat="server" Visible="false"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="col input-tag">
                </div>
                <div class="col-8">
                    <asp:Button class="btn btn-primary mybtn" ID="CopyBtn" runat="server" Text="Copy" OnClick="CopyBtn_Click" />
                    <asp:Button class="btn btn-primary mybtn" ID="ResetBtn" runat="server" Text="Reset" OnClick="ResetBtn_Click" />
                </div>
            </div>

        </div>
    </form>
</body>
</html>
