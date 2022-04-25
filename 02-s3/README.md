# Topic 2: Simple Storage Service (S3)

<!-- TOC -->

- [Topic 2: Simple Storage Service (S3)](#topic-2-simple-storage-service-s3)
  - [Guidance](#guidance)
  - [Lesson 2.1: Introduction to S3 with awscli](#lesson-21-introduction-to-s3-with-awscli)
    - [Principle 2.1](#principle-21)
    - [Practice 2.1](#practice-21)
      - [Lab 2.1.1: Create a Bucket](#lab-211-create-a-bucket)
      - [Lab 2.1.2: Upload Objects to a Bucket](#lab-212-upload-objects-to-a-bucket)
        - [Question: Copying to Top Level](#question-copying-to-top-level)
        - [Question: Directory Copying](#question-directory-copying)
        - [Question: Object Access](#question-object-access)
        - [Question: Sync vs Copy](#question-sync-vs-copy)
      - [Lab 2.1.3: Exclude Private Objects When Uploading to a Bucket](#lab-213-exclude-private-objects-when-uploading-to-a-bucket)
      - [Lab 2.1.4: Clean Up](#lab-214-clean-up)
    - [Retrospective 2.1](#retrospective-21)
  - [Lesson 2.2: Intro to S3 Permissions](#lesson-22-intro-to-s3-permissions)
    - [Principle 2.2](#principle-22)
    - [Practice 2.2](#practice-22)
      - [Lab 2.2.1: Recreate the Bucket with Public Data](#lab-221-recreate-the-bucket-with-public-data)
        - [Question: Downloading Protection](#question-downloading-protection)
      - [Lab 2.2.2: Use the CLI to Restrict Access to Private Data](#lab-222-use-the-cli-to-restrict-access-to-private-data)
        - [Question: Modify Permissions](#question-modify-permissions)
        - [Question: Changing Permissions](#question-changing-permissions)
      - [Lab 2.2.3: Using the API from the CLI](#lab-223-using-the-api-from-the-cli)
      - [Question: Reading Policy](#question-reading-policy)
      - [Question: Default Permissions](#question-default-permissions)
      - [Lab 2.2.4: Using CloudFormation](#lab-224-using-cloudformation)
    - [Retrospective 2.2](#retrospective-22)
  - [Lesson 2.3: S3 Versioning and Lifecycle Policies](#lesson-23-s3-versioning-and-lifecycle-policies)
    - [Principle 2.3](#principle-23)
    - [Practice 2.3](#practice-23)
      - [Lab 2.3.1: Set up for Versioning](#lab-231-set-up-for-versioning)
      - [Lab 2.3.2: Object Versions](#lab-232-object-versions)
        - [Question: Deleted Object Versions](#question-deleted-object-versions)
        - [Question: Deleting All Versions](#question-deleting-all-versions)
      - [Lab 2.3.3: Tagging S3 Resources](#lab-233-tagging-s3-resources)
        - [Question: Deleting Tags](#question-deleting-tags)
      - [Lab 2.3.4: Object Lifecycles](#lab-234-object-lifecycles)
        - [Question: Improving Speed](#question-improving-speed)
    - [Stretch Challenge](#stretch-challenge)
    - [Retrospective 2.3](#retrospective-23)
  - [Lesson 2.4: S3 Object Encryption](#lesson-24-s3-object-encryption)
    - [Principle 2.4](#principle-24)
    - [Practice 2.4](#practice-24)
      - [Lab 2.4.1: Server-Side Encryption](#lab-241-server-side-encryption)
        - [Question: Encrypting Existing Objects](#question-encrypting-existing-objects)
      - [Lab 2.4.2: SSE with KMS Keys](#lab-242-sse-with-kms-keys)
        - [Question: KMS vs S3 Managed Keys](#question-kms-vs-s3-managed-keys)
        - [Question: Customer Managed CMK](#question-customer-managed-cmk)
      - [Lab 2.4.3: Using Your Own KMS Key](#lab-243-using-your-own-kms-key)
        - [Question: CMK Alias](#question-cmk-alias)
    - [Retrospective 2.4](#retrospective-24)
      - [Question: Requiring Encryption](#question-requiring-encryption)
      - [Question: Multiple Keys](#question-multiple-keys)
  - [Further Reading](#further-reading)

<!-- /TOC -->

## Guidance

- Use the [AWS S3 Developer Guide](https://docs.aws.amazon.com/AmazonS3/latest/dev/Introduction.html)
  as much as possible.

- Avoid using other sites like stackoverflow.com for answers \-- part
  of the skill set you are building is finding answers straight from
  the source, AWS.

- Explore your curiosity. Try to understand why things work the way
  they do. Read more of the documentation than just what you need to
  find the answers.

For each section, you'll want to create a branch on your github repo,
push your changes to it. Consider this pattern "assumed" for
all labs going forward so we don't have to increase the length of the
document by copying / pasting "push these changes to your branch" fifty
times.

## Lesson 2.1: Introduction to S3 with awscli

### Principle 2.1

*S3 is an easy-to-use service for storing data in the cloud.*

### Practice 2.1

This section gets you familiar with the basic characteristics of S3
buckets and objects, and how you can interact with them from the command
line.

 In this practice session, we'll get familiar with the
[awscli's s3 command](https://docs.aws.amazon.com/cli/latest/reference/s3/).

#### Lab 2.1.1: Create a Bucket
**Note**
- Use the us-west-2 region.

- Call the bucket "compudemy-_your-AWS-username_".

S3 buckets are located in regions, but their names are globally unique.
Using "aws s3", create a bucket:
- First, you need to create an Amazon S3 bucket where you will store your objects.

- Sign in to the AWS Management Console.
- Select S3 service
- From the Amazon S3 console dashboard, choose Create Bucket.

![image](https://user-images.githubusercontent.com/103466963/163441737-8e99dc10-ba41-443c-bc2c-2f74c0b6a9b6.png)


- In Create a Bucket, type a bucket name in Bucket Name.
The bucket name you choose must be globally unique across all existing bucket names in Amazon S3 (that is, across all AWS customers). For more information, see Bucket Restrictions and Limitations.
- Choose Create, When Amazon S3 successfully creates your bucket click on the bucket you created to see the contents of the bucket. At this point the bucket has (0)objects because nothing has been uploaded in the bucket.

![image](https://user-images.githubusercontent.com/103466963/163442034-7341bb8b-2c6d-416b-be78-4d9cb1f1a550.png)

in order to see all the buckets you have created, type in the command aws s3 ls, this command will list all the buckets in your account. Based on the image below we have just one bucket in this account 

![image](https://user-images.githubusercontent.com/103466963/163445806-0e8d9e05-0e9b-43fc-8f13-665152338c4c.png)

- List the contents of the bucket. To List the contents of a specific bucket, open the command line and type in the command below, replace compudemy-your-AWS-username with the name you entered when creating your bucket. 

**aws s3 ls s3://compudemy-your-AWS-username**

#### Lab 2.1.2: Upload Objects to a Bucket
**Preparing Your AWS S3 Access**
- Creating an IAM User with S3 Access Permission
When accessing AWS using the CLI, you will need to create one or more IAM users with enough access to the resources you intend to work with. In this section, you will create an IAM user with access to Amazon S3.
- To create an IAM user with access to Amazon S3, you first need to login to your AWS IAM console. Under the Access management group, click on Users. Next, click on Add user, see link attached.

![image](https://user-images.githubusercontent.com/103466963/163432017-3d0babf0-549c-446d-9be8-34373d272b13.png)

- Type in the IAM user’s name you are creating inside the User name* box such as s3Admin. In the Access type* selection, put a check on Programmatic access. Then, click the Next: Permissions button
 
![image](https://user-images.githubusercontent.com/103466963/163433262-69166c1c-efb6-4582-bad4-1e539d28257c.png)

- Next, click on Attach existing policies directly. Then, search for the AmazonS3FullAccess policy name and put a check on it. When done, click on Next: Tags.

![image](https://user-images.githubusercontent.com/103466963/163435663-179bc974-d6b9-40ab-b97d-478257e0780c.png)

- Creating tags is optional in the Add tags page, and you can just skip this and click on the Next: Review button.
- In the Review page, you are presented with a summary of the new account being created. Click Create user.
- 
![image](https://user-images.githubusercontent.com/103466963/163436310-5161f1b7-4390-484a-a5d2-cb01f0cca294.png)

- Finally, once the user is created, you must download csv or copy the Access key ID and the Secret access key values and save them for later user. Note that this is the only time that you can see these values

![image](https://user-images.githubusercontent.com/103466963/163437064-5580d776-d765-477d-9a21-3b4a03e229d4.png)
 **Setting Up an AWS Profile On Your Computer**
Now that you’ve created the IAM user with the appropriate access to Amazon S3, the next step is to set up the AWS CLI profile on your computer.

This section assumes that you already installed the AWS CLI version 2 tool as required. For the profile creation, you will need the following information:
- To create the profile, open PowerShell, and type the command below and follow the prompts.

**aws configure**
Enter the Access key ID, Secret access key, Default region name, and default output name.

![image](https://user-images.githubusercontent.com/103466963/163439033-53347208-463d-4fc2-96ff-882ef76169f6.png)

**Add an object to your bucket:**
- Create a local subdirectory called, "data", for s3 files and put a few
  files in it.

- Copy the file to your bucket using the "aws s3" command. Find more
  than one way to upload it.
  **Uploading Individual Files to S3**
When you upload files to S3, you can upload one file at a time, or by uploading multiple files and folders recursively. Depending on your requirements, you may choose one over the other that you deem appropriate.
To upload a file to S3, you’ll need to provide two arguments (source and destination) to the aws s3 cp command.

For example, to upload individual files to the bucket you created, you can use the command below.

**-	aws s3 cp --recursive "C:\Users\Lenovo\Desktop\data" s3://compudemy-your-aws-username/** It gives you an ouput similar to the one below

![image](https://user-images.githubusercontent.com/103466963/163605478-a522c861-3875-4d2d-a9af-72b1249fd31d.png)


You can open your s3 console and check to see the files you just uploaded. in this case two files were uploaded as see below

![image](https://user-images.githubusercontent.com/103466963/163604612-d437cb68-29e5-4869-8da7-28d39b7090d7.png)

Note: S3 bucket names are always prefixed with S3:// when used with AWS CLI
- List the contents of the bucket after each upload.
Use the command below to list the objects at the root of the S3 bucket.
**aws s3 ls s3://compudemy-your-AWS-username**
This command will list the contents of your S3 bucket as seen below

![image](https://user-images.githubusercontent.com/103466963/163605731-67b879ff-1624-4d8f-90de-3a0acebc81bc.png)


##### Question: Copying to Top Level

_How would you copy the contents of the directory to the top level of your bucket?_

##### Question: Directory Copying

_How would you copy the contents and include the directory name in the s3 object
paths?_

##### Question: Object Access

_[Can anyone else see your file yet](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html)?_

For further reading, see the S3 [Access Policy Language Overview](https://docs.aws.amazon.com/AmazonS3/latest/dev/access-policy-language-overview.html).

##### Question: Sync vs Copy

_What makes "sync" a better choice than "cp" for some S3 uploads?_

aws s3 cp will copy all files, even if they already exist in the destination area. It also will not delete files from your destination if they are deleted from the source. aws s3 sync looks at the destination before copying files over and only copies over files that are new and updated.
The sync command is better because it is designed to handle keeping two folders in sync while copying the minimum amount of data. Sync should result in less data being pushed into S3 bucket so that should have a less cost overall.

#### Lab 2.1.3: Exclude Private Objects When Uploading to a Bucket

 Add a private file to your data directory. Then, upload the directory to you*. There are three files in the data directory, all files will be copied except the "private.txt" using the following command

**aws s3 cp --recursive "C:\Users\Lenovo\Desktop\data" s3://compudemy-your-aws-username/ --exclude "private.txt*"**

![image](https://user-images.githubusercontent.com/103466963/163622325-627513f1-540b-464f-8824-1a1bbf0411f9.png)


- Verify after uploading that the file doesn't exist in the bucket.
  From the image below it can be observed that the file "private.txt does not exist in the bucket
  
  ![image](https://user-images.githubusercontent.com/103466963/163626127-5fa1e8c6-98e0-49ee-823a-db1d9fda66b6.png)

- Did you find two different ways to accomplish this task? If not, make sure to
  read the [documentation on sync flags](https://docs.aws.amazon.com/cli/latest/reference/s3/sync.html).

#### Lab 2.1.4: Clean Up

Clean up: remove your bucket. What do you have to do before you can
remove it?
- Make sure the bucket is empty – You can only delete buckets that don't have any objects in them. Make sure the bucket is empty.

- s3:DeleteBucket permissions – If you cannot delete a bucket, work with your IAM administrator to confirm that you have s3:DeleteBucket permissions in your IAM user policy.

- s3:DeleteBucket deny statement – If you have s3:DeleteBucket permissions in your IAM policy and you cannot delete a bucket, the bucket policy might include a deny statement for s3:DeleteBucket.
-  Buckets created by ElasticBeanstalk have a policy containing this statement by default. Before you can delete the bucket, you must delete this statement or the bucket policy.

### Retrospective 2.1

For additional s3 commands and reference see the
[AWS CLI Command Reference](https://docs.aws.amazon.com/cli/latest/reference/s3/)

## Lesson 2.2: Intro to S3 Permissions

### Principle 2.2

*S3 has fine-grained access controls that can let you share files with
individuals or the public.*

### Practice 2.2

#### Lab 2.2.1: Recreate the Bucket with Public Data

Create your bucket again and upload the contents of your "data"
directory with the "aws s3 sync" command.
To create the bucket, do thesame as you did previously using the same  bucket name, the only difference now is you uncheck the box that says block public access in order for the bucket to be visible to others.

![image](https://user-images.githubusercontent.com/103466963/163628886-b08ef0cd-59c3-47b9-921f-cd52d8f87745.png)

- Include the "private.txt" file this time.
  Use the following command to copy the files from the local directory to the S3 bucket with the private.txt file included. Previously we did upload the files and excluded the private.txt file. However here we are going to include the private.txt file when copying the local directory to the buck. Use the following sync command to execute that task
  
  **aws s3 sync C:\Users\Lenovo\Desktop\Data1 s3://compudemy-your-aws-username**
  ,you can see the oupt below, it uploads all the files with the private.txt file inclusive
  
 ![image](https://user-images.githubusercontent.com/103466963/163631515-e0175f66-d1e2-4cee-a724-8396bba6b2ce.png)
 
You can go to the s3 console and you will see that the files have been uploaded to the bucket, it should look similar to the one below

![image](https://user-images.githubusercontent.com/103466963/163631846-f397b74f-3555-4f28-b542-df3d24f06a29.png)

- Use a "sync" command parameter to make all the files in the bucket
  publicly readable.
  
  **aws s3 sync C:\Users\Lenovo\Desktop\Data1 s3://compudemy-your-aws-username/C:\Users\Lenovo\Desktop\Data1 --acl public-read**
  
  To know if the files are publicly accessible, copy the URL of the object and paste on a new tap and if you get an access denied then your bucket and its contents cannot be publicly accessed. However if your bucket is open to the public then you should be able to see what is in the file

##### Question: Downloading Protection

_After this, can you download one of your files from the bucket without using
your API credentials?_
Yes a file can be downloaded by going to the particular file , then click on download. in the case where you have thousands of files that you want to download, downloading individual files will be time consuming. Here you are trying to copy the files from your S3 bucket to your local directory/folder where you want to store the files. you can either use the command propmt to create a folder or create the folder manually where you want the files to be store. Once the folder is created, you need to change to that local directory. lets say the folder you created is called data where your files will be stored. To change to this directory enter the command

**cd data**
To download files in this current directory enter the command below

**aws s3 sync s3://compudemy-your-aws-username .**
Dont forget to include the dot at the end of the command because the dot indicates that the files are being downloaded into the current directory called data.
Looking at the image that follows you will observe that three files have been successfully downloaded and stored into the local directory which was specified. To verify if the files are present, open the local directory and you should be able to see the files 

![image)](https://user-images.githubusercontent.com/103466963/165136448-deb11f47-6497-472a-ab66-4d0db282a0b3.png)

#### Lab 2.2.2: Use the CLI to Restrict Access to Private Data

You just made "private.txt" publicly readable. Ensure that only the
bucket owner can read or write that file without changing the
permissions of the other files.

##### Question: Modify Permissions

_How could you use "aws s3 cp" or "aws s3 sync" command to modify the
permissions on the file?_

(Hint: see the list of [Canned ACLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl).)

##### Question: Changing Permissions

_Is there a way you can change the permissions on the file without re-uploading it?_

#### Lab 2.2.3: Using the API from the CLI

The [aws s3api command](https://docs.aws.amazon.com/cli/latest/reference/s3api/index.html#s3api)
gives you a lot more options. Remove the bucket again, then recreate it
to start fresh.

Make all files publicly readable, grant yourself access to do anything
to all files, and block access to "private.txt" unless you're an
authenticated user:

To create the bucket run the following api command

**s3api create-bucket --bucket compudemy-your-aws-username --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2**


- Create and assign an IAM policy to explicitly grant yourself
  maintenance access.

- Set a bucket policy to grant public read access. To grant the bucket access to the public, click on the the bucket then go to permission and under policy attach this policy to the bucket and it will make that buckect and its contenet open to the public

![image](https://user-images.githubusercontent.com/103466963/165110793-dca55d65-9fb1-4f11-9e21-573268d49039.png)

After attaching this policy you will discover that the bucket and its content becomes public as seen below

![image](https://user-images.githubusercontent.com/103466963/165111705-83828c72-4f46-462e-bbfd-a0f00cf01bef.png)

There is a particular file called private.txt which is not supposed to be open to the public. Just the bucket owner should have full ownership of the bucket. Go ahead to Set an S3 ACL on "private.txt" to block read access unless you're
  authenticated.

When you're done, verify that anybody (e.g. you, unauthenticated) can
read most files but can't read "private.txt", and only you can modify
file and read "private.txt".

#### Question: Reading Policy

_What do you see when you try to read the existing bucket policy before you
replace it?_

#### Question: Default Permissions

_How do the default permissions differ from the policy you're setting?_

#### Lab 2.2.4: Using CloudFormation

It's valuable to know about the s3api command, but you're much more
likely to be managing S3 resources with CloudFormation. Repeat Lab 2.2.3,
but this time do it all with CloudFormation instead of the awscli.

Note that not everything can be done using the same mechanisms in a
single template. To keep things simple, implement all of the permissions
using a single bucket policy.

When you're done, verify your access again.

### Retrospective 2.2

See [this AWS security blog post](https://aws.amazon.com/blogs/security/iam-policies-and-bucket-policies-and-acls-oh-my-controlling-access-to-s3-resources/)
for a nice explanation of how IAM S3 policies, bucket policies, and S3
ACLs work together. Also take a look at
[Guidelines for Using the Available Access Policy Options](https://docs.aws.amazon.com/AmazonS3/latest/dev/access-policy-alternatives-guidelines.html)
for information about user policies, resource policies, and ACLs.
[Bucket Policy Examples](https://docs.aws.amazon.com/AmazonS3/latest/dev/example-bucket-policies.html)
may also be useful.

## Lesson 2.3: S3 Versioning and Lifecycle Policies

### Principle 2.3

*S3 is the go-to solution when working with data that should be
versioned or have a lifecycle.*

### Practice 2.3

See [Object Versioning](https://docs.aws.amazon.com/AmazonS3/latest/dev/ObjectVersioning.html),
[Lifecycle Management](https://docs.aws.amazon.com/AmazonS3/latest/dev/object-lifecycle-mgmt.html),
and [Storage Class Analysis](https://docs.aws.amazon.com/AmazonS3/latest/dev/analytics-storage-class.html)
in the S3 docs for information on the labs below. You'll use both the
CLI & CloudFormation. In a professional capacity, you're much more likely to
write policies and bucket options with CloudFormation, and they're
easier to write in its templating language, but some of these tasks \--
like those managing data \-- require the CLI.

#### Lab 2.3.1: Set up for Versioning

Experiment with bucket versioning. Using the CLI, delete the bucket
stack you created for Principle 2, so that we can start out fresh. Make
a copy of the stack template you just wrote above, and modify it for
this lab:

- Create the stack with versioning enabled on the bucket

- Upload your local data files to the bucket with the CLI.

- Modify your local data files, and sync those files to the bucket
  again.

- Inspect your bucket's objects after syncing and see how many
  versions there are.

- Fetch the original version of an object.

#### Lab 2.3.2: Object Versions

Delete one of the objects that you changed.

##### Question: Deleted Object Versions

_Can you still retrieve old versions of the object you removed?_

##### Question: Deleting All Versions

_How would you delete all versions?_

#### Lab 2.3.3: Tagging S3 Resources

Tag one or more of your objects or buckets using "aws s3api", or add
tags to your bucket through CloudFormation. View the tags on them
through the CLI or the console.

##### Question: Deleting Tags

_Can you change a single tag on a bucket or object, or do you have to change
all its tags at once?_

(See `aws:cloudformation:stack-id` and other AWS-managed tags.)

#### Lab 2.3.4: Object Lifecycles

Create a lifecycle policy for the bucket:

- Move objects to the Infrequent Access class after 30 days.

- Move them to Glacier after 90 days.

- Expire all noncurrent object versions after 7 days.

- Remove all aborted multipart uploads after 1 day.

After updating your stack, use the [S3 console's](https://console.aws.amazon.com/s3/)
_Management Lifecycle_ tab to double-check your settings.

##### Question: Improving Speed

_Can you make any of these transitions more quickly?_

*See the [S3 lifecycle transitions doc](https://docs.aws.amazon.com/AmazonS3/latest/dev/lifecycle-transition-general-considerations.html).*

### Stretch Challenge

For objects with the tag you assigned earlier and under the `trash/` prefix,
expire them after 1 day.

### Retrospective 2.3

*How could the lifecycle and versioning features of S3 be used to manage
the lifecycle of a web application? Would you use those features to manage
the webapp code itself, or just the app's data?*

## Lesson 2.4: S3 Object Encryption

### Principle 2.4

*S3 as an excellent, easy-to-use solution for keeping data secure in
transit and at rest.*

### Practice 2.4

See [Protecting Data Using Encryption](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingEncryption.html)
for information on the labs below.

#### Lab 2.4.1: Server-Side Encryption

Modify your bucket policy to require server-side encryption with an
S3-managed key ("SSE-S3").

##### Question: Encrypting Existing Objects

_Do you need to re-upload all your files to get them encrypted?_

#### Lab 2.4.2: SSE with KMS Keys

Change your bucket policy to require KMS encryption for all objects.

- Update your stack.

- Use the S3 API to identify the key used to encrypt one of the files
  in your bucket.

- Modify the local copy of that file and re-sync your bucket

- Let S3 generate a CMK for you.

- Use the S3 API again to check the key ID.

The 1st key should be the S3-managed AES key. The 2nd should be your KMS
key.

##### Question: KMS vs S3 Managed Keys

_Look through the [S3 encryption docs](https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html).
What benefits might you gain by using a KMS key instead of an S3-managed key?_

##### Question: Customer Managed CMK

_Going further, what benefits might you gain by using a KMS key you created
yourself?_

#### Lab 2.4.3: Using Your Own KMS Key

Use your own KMS key to encrypt files in S3.

- Generate a new KMS key by adding an
  [AWS::KMS::Key](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-kms-key.html)
  to your stack or using the "[aws kms create-key](https://docs.aws.amazon.com/cli/latest/reference/kms/create-key.html)"
  command.

- Assign an alias to the key as well.

- Re-upload some of your test files using that key.

- Again use the S3 API to verify the key ID used on objects before and
  after the change.

##### Question: CMK Alias

_Can you use the alias when uploading files?_

### Retrospective 2.4

#### Question: Requiring Encryption

_After changing your bucket policy, can you upload files that aren't encrypted?
If so, how would you require encryption on all files?_

#### Question: Multiple Keys

_Can you use different keys for different objects?_

## Further Reading

- S3 [objects](https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingObjects.html)
  are not files. The
  [index document support](https://docs.aws.amazon.com/AmazonS3/latest/dev/IndexDocumentSupport.html)
  for web hosting is one use case that makes the difference clear.

- S3 can be used for
  [static web hosting](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html).
  It's a fantastic service and good to know about, even if you won't
  use it on most client engagements.
  [S3 routing rules](https://docs.aws.amazon.com/AmazonS3/latest/dev/how-to-page-redirect.html#advanced-conditional-redirects)
  let you do more than merely host a set of static files.

- [Event notifications](https://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html)
  open up a wide range of other use cases for S3.

- The S3 API (and CLI) and CloudFormation sometimes offer very
  different interfaces to the service. Note that the API gives you a
  [glacier command](https://docs.aws.amazon.com/cli/latest/userguide/cli-using-glacier.html)
  where you can manage storage vaults, but the
  [CFN Bucket resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-bucket.html)
  doesn't require you to maintain them explicitly.
  Compare the way bucket lifecycle policies are managed through
  [put-bucket-lifecycle-configuration](https://docs.aws.amazon.com/cli/latest/reference/s3api/put-bucket-lifecycle-configuration.html)
  and
  [AWS::S3::BucketPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-s3-policy.html),
  where the format of the policy language can be very different.

- [CloudFront](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/Introduction.html)
  is a powerful service that lets you make access to S3 objects more
  tightly controlled, more performant, and cheaper.

- When you have a wide geographic footprint,
  [Cross-Region Replication](https://docs.aws.amazon.com/AmazonS3/latest/dev/crr.html)
  offers a variety of useful benefits, like improved access speeds,
  cross-account ownership, and greater redundancy.
