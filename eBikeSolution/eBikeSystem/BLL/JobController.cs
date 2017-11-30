using eBike.Data.Entities;
using eBike.Data.POCOs;
using eBikeSystem.DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBikeSystem.BLL
{
    [DataObject]
    public class JobController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<JobListPoco> JobList()
        {
            using (var context = new eBikeContext())
            {
                var results = from x in context.Jobs
                              where x.JobDateOut == null
                              select new JobListPoco
                              {
                                 JobID = x.JobID,
                                 JobDateIn = x.JobDateIn,
                                 JobDateStarted = x.JobDateStarted,
                                 JobDateDone = x.JobDateDone,
                                 Name = x.Customer.LastName + ", " + x.Customer.FirstName,
                                 ContactPhone = x.Customer.ContactPhone
                                 
                              };
                return results.ToList();
            }
        }//eom

    }
}
