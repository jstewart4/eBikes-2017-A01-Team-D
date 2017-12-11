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
                              where string.IsNullOrEmpty(x.JobDateOut.ToString())
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

       
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<customerPOCO> customerList()
        {
            using (var context = new eBikeContext())
            {
                var results = from x in context.Customers
                              select new customerPOCO
                              {
                                  CustomerID = x.CustomerID,
                                  FirstName = x.FirstName,
                                  LastName = x.LastName
                              };

                return results.ToList();

            }

        }//eom


        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<StandardJob> presets()
        {
            using (var context = new eBikeContext())
            {
                var results = from x in context.StandardJobs
                              select x;

                return results.ToList();

            }
        }//eom


        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<Coupon> coupon()
        {
            using (var context = new eBikeContext())
            {
                var results = from x in context.Coupons
                              select x;

                return results.ToList();

            }
        }//eom



        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<JobDetail> JobDetail(int jobid)
        {
            using (var context = new eBikeContext())
            {
                var results = from x in context.JobDetails
                              where x.JobID.Equals(jobid)
                              select x;

                return results.ToList();

            }
        }//eom


        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<Part> ServiceParts(int jobid)
        {
            using (var context = new eBikeContext())
            {
                var results = from x in context.JobDetailParts
                              where x.JobDetailID == jobid
                              select x.Part;

                return results.ToList();

            }
        }//eom

        //public string Description(int presetid)
        //{
        //    using (var context = new eBikeContext())
        //    {
        //        var results = from x in context.StandardJobs
        //                      where x.JobID.Equals(presetid)
        //                      select x.Description;


        //        return results.ToString();
        //    }

        //}//eom
    }
}
