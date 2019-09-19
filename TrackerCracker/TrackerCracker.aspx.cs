using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace TrackerCracker
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void EncryptBtn_Click(object sender, EventArgs e)
        {
            this.result.Text = "";
            var passwordsElements = this.input.Text.Split(new[] { Environment.NewLine }, StringSplitOptions.None).ToList();
            var encryptedPassword = "";

            foreach (var password in passwordsElements)
            {
                var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(password);
                encryptedPassword = System.Convert.ToBase64String(plainTextBytes);
                this.result.Text += encryptedPassword + "\n";
            }
        }

        protected void DecryptBtn_Click(object sender, EventArgs e)
        {
            this.result.Text = "";
            string message = string.Empty;

            var passwordsElements = this.input.Text.Split(new[] { Environment.NewLine }, StringSplitOptions.None).ToList();
            var decryptedPassword = "";

            try
            {
                foreach (var password in passwordsElements)
                {
                    var base64EncodedBytes = System.Convert.FromBase64String(password);
                    decryptedPassword = System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
                    this.result.Text += decryptedPassword + "\n";
                }
            }
            catch (FormatException)
            {
                message = "Invalid base64 string";
            }

            inputError.Text = message;
            inputError.Visible = true;

        }

        protected void CopyBtn_Click(object sender, EventArgs e)
        {
            if (this.result.Text == string.Empty)
            {
                this.result.Text = "";
            }
            else
            {
                Thread thread = new Thread(() => Clipboard.SetText(this.result.Text));
                thread.SetApartmentState(ApartmentState.STA); //Set the thread to STA
                thread.Start();
                thread.Join(); //Wait for the thread to end
            }
        }

        protected void ResetBtn_Click(object sender, EventArgs e)
        {
            this.input.Text = "";
            this.result.Text = "";
        }

        protected void PasswordGenBtn_Click(object sender, EventArgs e)
        {
            var passwords = "";

            PasswordOptions pwOpts = new PasswordOptions()
            {
                RequiredLength = Int32.Parse(PwLength.SelectedValue),
                IncludeDigit = IncludeNum.Checked,
                IncludeLowercase = IncludeLowercaseChar.Checked,
                IncludeUppercase = IncludeUppercaseChar.Checked,
                IncludeSymbols = IncludeSymbols.Checked
            };

            var passwordList = GenerateRandomPassword(pwOpts);
            foreach (var pw in passwordList)
            {
                passwords += pw + "\n";
            }
            PasswordArea.Value = passwords;

            //PasswordArea.Value = pwOpts.IncludeDigit.ToString() + pwOpts.IncludeLowercase.ToString() 
            //    + pwOpts.IncludeUppercase.ToString() + pwOpts.IncludeSymbols.ToString();
        }

        public List<string> GenerateRandomPassword(PasswordOptions opts)
        {
            var numOfPwNeeded = Int32.Parse(PwQuality.SelectedValue);

            List<string> passwordList = new List<string>();
            List<string> randomChars = new List<string>();

            Random rand = new Random(Environment.TickCount);


            for (int j = 0; j < numOfPwNeeded; j++)
            {
                List<char> chars = new List<char>();

                if (opts == null)
                {
                    opts = new PasswordOptions()
                    {
                        RequiredLength = 8,
                        IncludeDigit = true,
                        IncludeLowercase = true,
                        IncludeUppercase = true,
                        IncludeSymbols = true,
                    };
                    PasswordArea.Value = opts.RequiredLength.ToString() + opts.IncludeDigit.ToString()
                        + opts.IncludeLowercase.ToString() + opts.IncludeUppercase.ToString() + opts.IncludeSymbols.ToString();
                }



                if (opts.IncludeDigit)
                    randomChars.Add("0123456789");

                if (opts.IncludeLowercase)
                    randomChars.Add("abcdefghijkmnopqrstuvwxyz");

                if (opts.IncludeUppercase)
                    randomChars.Add("ABCDEFGHJKLMNOPQRSTUVWXYZ");

                if (opts.IncludeSymbols)
                    randomChars.Add("~!@#$%^&*()-+=?/<>|[]{}_ :;.,\\`.");

                for (int i = chars.Count; i < opts.RequiredLength; i++)
                {
                    string rcs = randomChars[rand.Next(0, randomChars.Count)];
                    chars.Insert(rand.Next(0, chars.Count),
                        rcs[rand.Next(0, rcs.Length)]);
                }


                passwordList.Add(new string(chars.ToArray()));
            }

            return passwordList;
        }
        protected void PwCopyBtn_Click(object sender, EventArgs e)
        {
            if (this.PasswordArea.Value == string.Empty)
            {
                this.PasswordArea.Value = "";
            }
            else
            {
                Thread thread = new Thread(() => Clipboard.SetText(this.PasswordArea.Value));
                thread.SetApartmentState(ApartmentState.STA); //Set the thread to STA
                thread.Start();
                thread.Join(); //Wait for the thread to end
            }
        }
        protected void PwClearBtn_Click(object sender, EventArgs e)
        {
            PasswordArea.Value = "";
        }
    }
}