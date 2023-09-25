using System;
using System.IO;
using System.Drawing;
using System.Web.UI.WebControls;
using ClosedXML.Excel;
using System.Collections.Generic;
using System.Web;
using System.Text;
using DocumentFormat.OpenXml.Wordprocessing;
using static ClosedXML.Excel.XLPredefinedFormat;
using System.Data.SqlClient;
using System.Data;
using Color = System.Drawing.Color;
using DocumentFormat.OpenXml.Office2010.Excel;
using DocumentFormat.OpenXml.Office.Word;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void BtnSubir_Click(object sender, EventArgs e)
    {
        // Comprobar que se cargo un archivo
        if (fileUpload.HasFile)
        {
            try
            {
                // Comprobar que el archivo cargado sea un excel
                string extension = Path.GetExtension(fileUpload.FileName), mensaje = string.Empty;
                if (extension.ToLower() == ".xlsx" || extension.ToLower() == ".xlsm")
                {
                    // Obtener el archivo cargado desde el control FileUpload
                    HttpPostedFile archivoCargado = fileUpload.PostedFile;

                    List<Persona> listaPersonas = LeerExcel(archivoCargado);

                    // Si la lista contiene más de una fila realiza el insert, de otro modo muestra un mensaje
                    if (listaPersonas.Count > 0)
                    {
                        DataTable dt = crearTablaPersonas(listaPersonas);

                        InsertarTabla(dt);
                    }
                    else
                    {
                        mensaje = "El archivo se encuentra vacío";
                        MostrarMensaje(lblRespuesta, mensaje, Color.Orange);
                    }
                }
                else
                {
                    mensaje = "Por favor, selecciona un archivo de Excel (.xlsx o .xlsm)";
                    MostrarMensaje(lblRespuesta, mensaje, Color.Orange);
                }
            }
            catch (Exception ex)
            {
                string mensaje = "Error al subir el archivo: " + ex.Message;
                MostrarMensaje(lblRespuesta, mensaje, Color.Red);
            }
        } else {
            string mensaje = "Por favor, primero seleccione el archivo a importar";
            MostrarMensaje(lblRespuesta, mensaje, Color.Orange);
        }
    }

    private void MostrarMensaje(Label label, string mensaje, Color color)
    {
        // Mensaje de retroalimentacion
        label.Text = mensaje;
        label.ForeColor = color;
        label.Visible = true;
    }

    private List<Persona> LeerExcel (HttpPostedFile archivo)
    {
        List<Persona> listaPersonas = new List<Persona>();

        // Crear un ms y pasar el archivo a este
        using (MemoryStream ms = new MemoryStream())
        {
            archivo.InputStream.CopyTo(ms);

            // Crear un nuevo ClosedXML object con el memory stream del archivo cargado
            using (XLWorkbook excel = new XLWorkbook(ms))
            {
                // Suponiendo que los datos están en la primer hoja del doc
                var hoja = excel.Worksheet(1);

                bool esHeader = true;

                // Recorrer el excel y guardarlo en una lista
                foreach (var fila in hoja.RowsUsed())
                {
                    if (esHeader)
                    {
                        esHeader = false;
                        continue;
                    }

                    Persona persona = new Persona
                    {
                        Id = Convert.ToInt32(fila.Cell(1).Value.ToString()),
                        Nombre = fila.Cell(2).Value.ToString(),
                        Telefono = fila.Cell(3).Value.ToString()
                    };

                    listaPersonas.Add(persona);
                }

                // COMENTAR ESTO
                //debugger.DataSource = listaPersonas;
                //debugger.DataBind();
            }
        }

        return listaPersonas;
    }

    private DataTable crearTablaPersonas(List<Persona> lista)
    {
        // Crear una tabla identica a la de la BD y luego la llenamos con los datos de la lista previa
        DataTable tabla = new DataTable();
        tabla.Columns.Add("Id", typeof(int));
        tabla.Columns.Add("Nombre", typeof(string));
        tabla.Columns.Add("Telefono", typeof(string));

        foreach (var persona in lista)
        {
            tabla.Rows.Add(persona.Id, persona.Nombre, persona.Telefono);
        }

        return tabla;
    }

    private void InsertarTabla(DataTable tabla)
    {
        int res = 0;
        using (SqlConnection Conn = conn.Conecta())
        {
            using (SqlCommand comand = new SqlCommand("InsertarPersonas", Conn))
            {
                comand.CommandType = CommandType.StoredProcedure;

                SqlParameter parameter = comand.Parameters.AddWithValue("@personas", tabla);
                parameter.SqlDbType = SqlDbType.Structured;

                SqlParameter pres = new SqlParameter("@res", SqlDbType.Int);
                pres.Direction = ParameterDirection.Output;
                comand.Parameters.Add(pres);

                Conn.Open();
                comand.ExecuteNonQuery();

                res = Convert.ToInt32(pres.Value);

                if (res == 1)
                {
                    string mensaje = "Excel importado correctamente";
                    MostrarMensaje(lblRespuesta, mensaje, Color.Green);
                }  
            }
            Conn.Close();

        }
    }

}