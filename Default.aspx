<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Leer Excel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous"/>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div>
                <h1>IMPORTAR EXCEL A BD</h1>
            </div>
            <div class="row mb-3">
                <div class="col-md-6 col-12">
                    <label for="formFile" class="form-label">Seleccione el archivo de excel</label>
                    <asp:FileUpload CssClass="form-control mb-2" ID="fileUpload" runat="server" onchange="limpiaMensaje()"/>
                    <asp:Button CssClass="btn btn-primary mb-2" ID="btnUpload" runat="server" Text="Importar" OnClick="BtnSubir_Click" />
                </div>
                <div class="col-12">
                    <asp:Label ID="lblRespuesta" runat="server" Visible="false"></asp:Label>
                </div>
            </div>
            <%--COMENTAR ESTO--%>
            <%--<div>
                <asp:GridView ID="debugger" runat="server" AutoGenerateColumns="true"></asp:GridView>
            </div>--%>
        </div>
    </form>

    <script>
        function limpiaMensaje() {
            const lblRespuesta = document.getElementById('<%= lblRespuesta.ClientID %>');

            if (lblRespuesta.style.display !== 'none') {
                lblRespuesta.style.display = 'none';
            }
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
