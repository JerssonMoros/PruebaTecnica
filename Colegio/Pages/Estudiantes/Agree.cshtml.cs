using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace Colegio.Pages.Estudiantes
{
    public class CreateModel : PageModel
    {
        public EstudianteInfo estudianteInfo = new EstudianteInfo();
        public String error = "";
        public String guardado = "";
        public void OnGet()
        {
        }
        public void OnPost()
        {
            estudianteInfo.nombre = Request.Form["name"];
            estudianteInfo.apellido = Request.Form["last_name"];
            estudianteInfo.documento = Request.Form["document"];
            estudianteInfo.curso = Request.Form["curse"];
            estudianteInfo.materia = Request.Form["matter"];
            estudianteInfo.periodo = Request.Form["period"];
            estudianteInfo.nota = Request.Form["note"];
            if (estudianteInfo.nombre.Length == 0 || estudianteInfo.apellido.Length == 0 || estudianteInfo.curso.Length == 0 || estudianteInfo.materia.Length == 0 ||
                estudianteInfo.periodo.Length == 0 || estudianteInfo.nota.Length == 0 || estudianteInfo.documento.Length == 0 )
            {
                error = "** Se requiere que llene todos los campos";
                return;
            }

            //Guardar el nuevo cliente en la base de datos

            try
            {
                var builder = new SqlConnectionStringBuilder();
                builder.DataSource = ".\\sqlexpress";
                builder.InitialCatalog = "Colegio";
                builder.IntegratedSecurity = true;

                var cs = builder.ToString();

                using (SqlConnection sql = new SqlConnection(cs))
                {
                    sql.Open();
                    String sent = "INSERT dbo.Estudiante(Nombre, Apellido, Documento, Curso) VALUES (@name, @last_name, @document, @curse)";
                    using (SqlCommand cmd = new SqlCommand(sent, sql))
                    {

                        cmd.Parameters.AddWithValue("@name", estudianteInfo.nombre);
                        cmd.Parameters.AddWithValue("@last_name", estudianteInfo.apellido);
                        cmd.Parameters.AddWithValue("@document", estudianteInfo.documento);
                        cmd.Parameters.AddWithValue("@curse", estudianteInfo.curso);

                        cmd.ExecuteNonQuery();
                    }

                }

            }
            catch (Exception ex)
            {
                error = ex.Message;
                return;
            }

            estudianteInfo.nombre = "";
            estudianteInfo.apellido = "";
            estudianteInfo.documento = "";
            estudianteInfo.curso = "";
            estudianteInfo.materia = "";
            estudianteInfo.periodo = "";
            estudianteInfo.nota = "";
            guardado = "Datos Guardados!";

            Response.Redirect("/Estudiantes/Index");
        }
    }
}
