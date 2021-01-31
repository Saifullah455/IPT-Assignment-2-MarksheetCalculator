using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MarkSheet
{
    public partial class sample : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = true)]

        public static string StudentDetails()
        {
            string subjectStr = HttpContext.Current.Request.Params["request"];
            SubjectList[] Subjects = JsonConvert.DeserializeObject<SubjectList[]>(subjectStr);

            int totalMarks = 0;
            int securedMarks = 0;

            int minMarks = Subjects[0].marks;
            string minMarksSub = Subjects[0].subject;

            int maxMarks = Subjects[0].marks;
            string maxMarksSub = Subjects[0].subject;

            for (int i = 0; i < Subjects.Length; i++)
            {
                SubjectList currSub = Subjects[i];
                securedMarks += currSub.marks;
                totalMarks += 100;

                if (currSub.marks < minMarks)
                {
                    minMarks = currSub.marks;
                    minMarksSub = currSub.subject;
                }
                if (currSub.marks > maxMarks)
                {
                    maxMarks = currSub.marks;
                    maxMarksSub = currSub.subject;
                }
            }

            float percentage = (securedMarks * 100) / totalMarks;

            SelectedSubject result = new SelectedSubject();
            result.miniMarks = minMarks;
            result.maxiMarks = maxMarks;
            result.miniMarksSubject = minMarksSub;
            result.maxiMarksSubject = maxMarksSub;
            result.per = percentage;

            string resultStr = JsonConvert.SerializeObject(result);
            return resultStr;
        }

        public class SubjectList
        {
            public string subject { get; set; }
            public int marks { get; set; }
        }
        public class SelectedSubject
        {
            public int miniMarks { get; set; }
            public int maxiMarks { get; set; }
            public string miniMarksSubject { get; set; }
            public string maxiMarksSubject { get; set; }
            public float per { get; set; }
        }
    }
}