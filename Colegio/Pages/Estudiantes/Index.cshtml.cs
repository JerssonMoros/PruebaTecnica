using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Data.SqlClient;


namespace Colegio.Pages.Estudiantes
{
    public class IndexModel : PageModel
    {
        public List<EstudianteInfo> estudiantesInfo = new List<EstudianteInfo>();
        public void OnGet()
        {

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
                    //String sent = "SELECT * FROM Periodo";
                    String sent = "SELECT mep.id, e.Nombre, e.Apellido, e.Documento, e.Curso, m.NombreMateria, p.NombrePeriodo, mep.Nota " +
                        "FROM MateriaxEstudianteXPeriodo AS mep " +
                        "FULL JOIN  Estudiante AS e " +
                        "ON e.EstudianteID = mep.IDEstudiante " +
                        "FULL JOIN Materia AS m " +
                        "ON m.MateriaID = mep.IDMateria " +
                        "FULL JOIN Periodo AS p " +
                        "ON p.PeriodoID = mep.IDPeriodo ORDER BY e.Apellido asc";

                    using (SqlCommand cmd = new SqlCommand(sent, sql))
                    {
                        using (SqlDataReader rd = cmd.ExecuteReader())
                        {
                            while (rd.Read())
                            {
                                EstudianteInfo estudianteinfo = new EstudianteInfo();
                                estudianteinfo.id = "" + rd.GetInt32(0);
                                estudianteinfo.nombre = rd.GetString(1);
                                estudianteinfo.apellido = rd.GetString(2);
                                estudianteinfo.documento = "" + rd.GetInt32(3);
                                estudianteinfo.curso = "" + rd.GetInt32(4);
                                estudianteinfo.materia = rd.GetString(5);
                                estudianteinfo.periodo = rd.GetString(6);
                                estudianteinfo.nota = "" + rd.GetInt32(7);
                                Console.WriteLine(estudianteinfo);

                                estudiantesInfo.Add(estudianteinfo);
                            }
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine("Exception: " + ex.ToString());
            }
        }
    }

    public class EstudianteInfo
    {
        public String id;
        public String nombre;
        public String apellido;
        public String documento;
        public String curso;
        public String materia;
        public String periodo;
        public String nota;

    }
}
