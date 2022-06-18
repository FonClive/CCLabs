# Topic 3: Identity and Access Management (IAM)

<!-- TOC -->

- [Topic 3: Identity and Access Management (IAM)](#topic-3-identity-and-access-management-iam)
  - [Conventions](#conventions)
  - [Lesson 3.1: Introduction to Identity and Access Management](#lesson-31-introduction-to-identity-and-access-management)
    - [Principle 3.1](#principle-31)
    - [Practice 3.1](#practice-31)
      - [Lab 3.1.1: IAM Role](#lab-311-iam-role)
      - [Lab 3.1.2: Customer Managed Policy](#lab-312-customer-managed-policy)
      - [Lab 3.1.3: Customer Managed Policy Re-Use](#lab-313-customer-managed-policy-re-use)
      - [Lab 3.1.4: AWS-Managed Policies](#lab-314-aws-managed-policies)
      - [Lab 3.1.5: Policy Simulator](#lab-315-policy-simulator)
      - [Lab 3.1.6: Clean Up](#lab-316-clean-up)
    - [Retrospective 3.1](#retrospective-31)
      - [Question: Stack Outputs](#question-stack-outputs)
      - [Task: Stack Outputs](#task-stack-outputs)
  - [Lesson 3.2: Trust Relationships & Assuming Roles](#lesson-32-trust-relationships--assuming-roles)
    - [Principle 3.2](#principle-32)
    - [Practice 3.2](#practice-32)
      - [Lab 3.2.1: Trust Policy](#lab-321-trust-policy)
      - [Lab 3.2.2: Explore the assumed role](#lab-322-explore-the-assumed-role)
      - [Lab 3.2.3: Add privileges to the role](#lab-323-add-privileges-to-the-role)
      - [Lab 3.2.4: Clean up](#lab-324-clean-up)
    - [Retrospective 3.2](#retrospective-32)
      - [Question: Inline vs Customer Managed Policies](#question-inline-vs-customer-managed-policies)
      - [Question: Role Assumption](#question-role-assumption)
  - [Lesson 3.3: Fine-Grained Controls With Policies](#lesson-33-fine-grained-controls-with-policies)
    - [Principle 3.3](#principle-33)
    - [Practice 3.3](#practice-33)
      - [Lab 3.3.1: Unrestricted access to a service](#lab-331-unrestricted-access-to-a-service)
      - [Lab 3.3.2: Resource restrictions](#lab-332-resource-restrictions)
      - [Lab 3.3.3: Conditional restrictions](#lab-333-conditional-restrictions)
    - [Retrospective](#retrospective)
      - [Question: Positive and Negative Tests](#question-positive-and-negative-tests)
      - [Task: Positive and Negative Tests](#task-positive-and-negative-tests)
      - [Question: Limiting Uploads](#question-limiting-uploads)
      - [Task: Limiting Uploads](#task-limiting-uploads)
  - [Further Reading](#further-reading)

<!-- /TOC -->

## Conventions

- All CloudFormation templates should be written in YAML

- Do NOT copy and paste CloudFormation templates from the Internet at
  large

- DO use the [CloudFormation documentation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-reference.html)

- DO utilize every link in this document; note how the AWS
  documentation is laid out

- DO use the AWS CLI for
  [CloudFormation](https://docs.aws.amazon.com/cli/latest/reference/cloudformation/index.html#)
  and
  [IAM](https://docs.aws.amazon.com/cli/latest/reference/iam/index.html)
  (NOT the Console) unless otherwise specified.

## Lesson 3.1: Introduction to Identity and Access Management

### Principle 3.1

*Identity and Access Management (IAM) is the **authentication and authorization service**
used to control access to virtually everything in AWS.*

### Practice 3.1

IAM consists of a set of services and resources that allow individuals
(and services) to authenticate with AWS and then authorizes those
entities to perform specific activities with specific services. Like
most authentication/authorization systems, IAM deals with the *concepts*
of users, groups and permissions, but not necessarily those precise
*entities*.

#### Lab 3.1.1: IAM Role

# Create a CFN template that specifies an IAM Role.

- Provide values only for required attributes.

- Using inline Policies, give the Role read-only access to all IAM
  resources.

- Create the Stack.

- Use the [awscli](https://docs.aws.amazon.com/cli/latest/reference/iam/index.html)
  to query the IAM service  <!-- /twice -->:

  - List all the Roles
  <!-- /  -- Describe the specific Role your Stack created.  -->
 

  ### Step one 
  - Declare the role policies of existing IAM resources
   ![Screenshot (463)](https://user-images.githubusercontent.com/103466963/166634484-771a7be2-9d75-4113-b2b1-10465d0571cc.png)
  -Here Lab 3-1-1 is our readonlyacess role and it will be given to all the IAM resourses(users)
  ![image](https://user-images.githubusercontent.com/103466963/166444303-271da9f4-e752-4f37-8d62-3f9a31b3bb2f.png)
   ### step two 
   ![image](https://user-images.githubusercontent.com/103466963/166444756-a450dadc-38cb-42da-af32-8387101a557f.png)
    Create a stack either by personally writing down codes in the template designer or uploading a ready template 
    this [example](https://cloudkatha.com/how-to-create-iam-role-using-cloudformation/) can help you create a template om your local.
    when the stack has been successfully created, Open either your local command line or cloudshell
    ### Step three
    - After configuring you aws account, type in "aws list-roles" to query all existing roles
    ![image](https://user-images.githubusercontent.com/103466963/166448899-c050936e-f09d-4d43-bf51-b44d7215a506.png)
   
   - The list of roles have been displayed on the 
   

#### Lab 3.1.2: Customer Managed Policy

How to Create Customer-Managed Policies in AWS

When you initially create your AWS (Amazon Web Services) account, only one AWS-managed policy is in place: AdministratorAccess. However, after you create the first user and log in to AWS using your new administrator account, you can access a large number of AWS-managed policies.

Whenever possible, you should use the AWS-managed policies to ensure that the policy receives automatic updates that reflect changes in AWS functionality. When using a customer-managed policy, you must perform any required updates manually. The following steps get you started using customer-managed policies

Steps to creating a Customer-Management Policies in AWS

Step 1

Sign in to AWS using your administrator account.

Step 2

Navigate to the IAM Management Console.

Step 3

Select Policies in the Navigation pane. You see the Welcome to Managed Policies page.

![image](https://user-images.githubusercontent.com/103466963/174418127-af05beb7-d96f-43e7-b4a0-dedc32e3346d.png)


The Welcome to Managed Policies page explains the policies' uses and gets you started.

Step 4

Click Get Started. You see a list of available AWS-managed policies, as shown. Each of the policy names starts with the word Amazon (to show that it's an AWS-managed policy), followed by the service name (EC2 in the figure), optionally followed by the target of the permission (such as ContainerRegistry), and ending with the kind of permission granted (such as FullAccess). When creating your own customer-managed policies, it's good to follow the same practice to make the names easier to use and consistent with their AWS-managed counterparts

![image](https://user-images.githubusercontent.com/103466963/174418170-4671514a-f4c5-4770-9379-447d8b114588.png)


The list of AWS-managed policies is relatively long.

N:B 
The policy list tells you the number of entities attached to a policy so that you know whether a policy is actually in use. You can also see the policy creation time and the time someone last edited it. The symbol on the left side of the policy shows the policy type, which is a stylized cube for AWS-managed policies.


![image](https://user-images.githubusercontent.com/103466963/174418029-be70b8ac-324b-460b-bcf2-a79f4b60504f.png)

Step 5

Click Create Policy.

![image](https://user-images.githubusercontent.com/103466963/174418049-9be6d527-ce1e-4018-aa37-5a7e0c70f0a7.png)

AWS provides three options for creating customer-managed policies.

You see the Create Policy page, shown. AWS provides three options for creating a new policy (in order of complexity):

Copy an AWS Managed Policy: An AWS-managed policy acts as a starting point. You then make changes required to customize the policy for your needs. Because this option helps ensure that you create a usable policy and requires the least work, you should use it whenever possible. This example assumes that you copy an existing AWS-managed policy because you follow this route most often.
Policy Generator: Relies on a wizardlike interface to either allow or deny actions against an AWS service. You can assign the permission to specific resources (in some cases) using an Amazon Resource Name, ARN, or to all resources (using an *, asterisk). (The discussion describes how to create and use ARNs.) A policy can contain multiple permissions, each of which appears as a statement within the policy. After you define policies, the wizard shows you the policy document, which you can edit manually if desired. The wizard uses the policy document to generate the policy. This is the best option to use when you need a single policy to cover multiple services.
Create Your Own Policy: Defines a policy completely by hand. All you see is the policy document page, which you must fill in manually using appropriate syntax and grammar. The discussion tells you more about how to create a policy completely manually. You use this option only when necessary because the time involved in creating the document is substantial and the potential for error is high

Step 6

Click Copy an AWS-Managed Policy. You see a listing of AWS-managed policies

![image](https://user-images.githubusercontent.com/103466963/174418292-e8d844f0-647c-4e81-bc2f-30109dcc27d7.png)

Choose the policy that you want to modify.

Step 7

Click Select next to the AWS-Managed policy that you want to use as the basis for your customer-managed policy. The example uses the AmazonEC2FullAccess policy as a starting point, but the same steps apply to modifying other policies. You see the Review Policy page shown.

![image](https://user-images.githubusercontent.com/103466963/174418331-03b06fad-88c0-469b-94f6-c5a8c04da2e6.png)

The Review Policy page shows the details about the policy you're modifying.


![image](https://user-images.githubusercontent.com/103466963/174418357-ecf90a43-2c91-4c79-b7f6-8c6642b84fa9.png)


Step 8

Type a new name in the Policy Name field.
The example uses MyCompanyEC2FullAccessNoCloudWatch as the policy name.

Step 9

Modify the Description field as needed to define the changes made. The example adds that the policy doesn't allow access to CloudWatch.

Step 10

Modify the Policy Document field as needed to reflect policy changes. The example removes the following policy section from the document: { "Effect": "Allow", "Action": "cloudwatch:*", "Resource": "*" },

![image](https://user-images.githubusercontent.com/103466963/174418487-92af01cc-c999-4d9b-a286-1c039838a408.png)

Step 11

Click Validate Policy. If the changes you made work as intended, you see a This Policy Is Valid success message at the top of the page. Always validate your policy before you create it.

Step 12

Click Create Policy. You see a success message on the Policies page, plus a new entry for your policy, as shown. Note that your policy doesn't include a policy type icon. The lack of an icon makes the policy easier to find in the list.

![image](https://user-images.githubusercontent.com/103466963/174418539-7a442eca-d53e-452f-9ec0-27b29bac47f7.png)

AWS tells you when you've successfully added a new policy.


#### Lab 3.1.4: AWS-Managed Policies

Replace the customer managed policy with
[AWS managed policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_managed-vs-inline.html#aws-managed-policies).

- To both roles, replace the customer managed policy reference with
  the corresponding AWS managed policy granting Read permissions to
  the IAM service.

- To the second role, add an additional AWS managed policy to grant
  Read permissions to the EC2 service.

- Update the stack.

#### Lab 3.1.5: Policy Simulator

Read about the [AWS Policy Simulator](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_testing-policies.html)
tool and practice using it.

- Using the two roles in your stack, simulate the ability of each role
  to perform the following actions (using the AWS CLI):

  - `iam:CreateRole`
  - `iam:ListRoles`
  - `iam:SimulatePrincipalPolicy`
  - `ec2:DescribeImages`
  - `ec2:RunInstances`
  - `ec2:DescribeSecurityGroups`

#### Lab 3.1.6: Clean Up

Clean up after yourself by deleting the stack.

### Retrospective 3.1

#### Question: Stack Outputs

_In Lab 3.1.5, you had to determine the Amazon resource Names (ARN) of the
stack's two roles in order to pass those values to the CLI function. You
probably used the AWS web console to get the ARN for each role. What
could you have done to your CFN template to make that unnecessary?_

#### Task: Stack Outputs

Institute that change from the Question above. Recreate the stack as per
Lab 3.1.5, and demonstrate how to retrieve the ARNs.

## Lesson 3.2: Trust Relationships & Assuming Roles

### Principle 3.2

*AWS service roles and other IAM principals can assume customer created
roles, enabling a principle-of-least-privilege of permissions for AWS
services and applications.*

### Practice 3.2

An IAM Role has two kinds of policies. The first we've worked with
already and this policy type (whether inline or managed) describes
permissions the role has. The second is a trust policy, describing which
AWS principles (services, roles and users) are allowed to masquerade as
that role.

For example, an AWS Lambda Function requires an execution role that
defines the permissions the function will have when it executes. To
provide those permissions, the role must trust the AWS Lambda service to
assume it, and this trust must be granted explicitly by the role.

In these labs, you will use your IAM User to assume roles in order to
explore policies and permissions.

#### Lab 3.2.1: Trust Policy

Create a CFN template that creates an IAM Role and makes it possible for
your User to assume that role.

- The role should reference the AWS managed policy ReadOnlyAccess.

- Add a trust relationship to the role that enables your specific IAM
  user to assume that role.

- Create the stack.

- Using the AWS CLI, assume that new role. If this fails, take note of
  the error you receive, diagnose the issue and fix it.

*Hint: Instead of setting up a new profile in your \~/.aws/credentials
file, use [aws sts assume-role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp_use-resources.html#using-temp-creds-sdk-cli).
It's a valuable mechanism you'll use often through the API, and it's good to
know how to do it from the CLI as well.*

#### Lab 3.2.2: Explore the assumed role

Test the capabilities of this new Role.

- Using the AWS CLI, assume that updated role and list the S3 buckets
  in the us-east-1 region.

- Acting as this role, try to create an S3 bucket using the AWS CLI.

  - Did it succeed? It should not have!
  - If it succeeded, troubleshoot how Read access allowed the role
    to create a bucket.

#### Lab 3.2.3: Add privileges to the role

Update the CFN template to give this role the ability to upload to S3
buckets.

- Create an S3 bucket.

- Using either an inline policy or an AWS managed policy, provide the
  role with S3 full access

- Update the stack.

- Assuming this role again, try to upload a text file to the bucket.

- If it failed, troubleshoot the error iteratively until the role is
  able to upload a file to the bucket.

#### Lab 3.2.4: Clean up

Clean up. Take the actions necessary to delete the stack.

### Retrospective 3.2

#### Question: Inline vs Customer Managed Policies

_In the context of an AWS User or Role, what is the difference between
an inline policy and a customer managed policy? What are the differences
between a customer managed policy and an AWS managed policy?_

#### Question: Role Assumption

_When assuming a role, are the permissions of the initial principal
mixed with those of the role being assumed?
Describe how that could easily be demonstrated with both a
[positive and negative testing](https://www.guru99.com/positive-vs-negative-testing.html)
approach._

## Lesson 3.3: Fine-Grained Controls With Policies

### Principle 3.3

*AWS policies can provide fine-grained access control to specific
resources using specific conditions.*

### Practice 3.3

So far we have only provided service-level IAM policy controls, but IAM
policies generally should be more specific than that. For example, a
service role for an application will generally only need read/write
access to those specific resources that the application uses, and even
then that resource might only be accessible under certain conditions.
[Actions, Resources, and Condition Keys for AWS Services](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_actions-resources-contextkeys.html)
introduces the topic. We'll be exploring Resource restrictions and
Condition keys in this lesson.

Keep in mind that not all resource types support resource-level
restrictions. See the Resource-level permissions information in
[AWS Services That Work with IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_aws-services-that-work-with-iam.html)
for details.

#### Lab 3.3.1: Unrestricted access to a service

Create a CFN template that generates two S3 buckets and a Role, and
demonstrate you have full access to each bucket with this new role.

- Code a Role your User can assume with a customer managed policy that
  allows full access to the S3 service.

- Create the stack.

- As your User:

  - list the contents of your 2 new buckets
  - upload a file to each new bucket

- Assume the new role and repeat those two checks as that role.

#### Lab 3.3.2: Resource restrictions

Add a resource restriction to the role's policy that limits full access
to the S3 service for just one of the two buckets and allows only
read-only access to the other.

- Update the stack.

- Assume the new role and perform these steps as that role:

  - List the contents of your 2 new buckets.
  - Upload a file to each new bucket.

*Were there any errors? If so, take note of them.*

*What were the results you expected, based on the role's policy?*

#### Lab 3.3.3: Conditional restrictions

Add a conditional restriction to the role's policy. Provide a condition
that grants list access only to objects that start with "lebowski/".

- Update the stack.

- Assume the new role and perform the remaining directives as that
  role.

- Try to list a file in the root of the available bucket

  - If it *worked*, fix your policy and update the stack until this
    fails.

- Try to list that same file but now with the proper object key
  prefix.

  - If it *doesn't work*, troubleshoot why and fix either the role's
    policy or the list command syntax until you are able to
    list a file.

### Retrospective

#### Question: Positive and Negative Tests

_Were the tests you ran for resource- and condition-specific
restrictions exhaustive? Did you consider additional [[positive and/or negative
tests]](https://smartbear.com/learn/automated-testing/negative-testing/)
that could be automated in order to confirm the permissions for the
Role?_

#### Task: Positive and Negative Tests

Code at least one new positive and one new negative test.

#### Question: Limiting Uploads

_Is it possible to limit uploads of objects with a specific prefix (e.g.
starting with "lebowski/") to an S3 bucket using IAM conditions? If not, how else
could this be accomplished?_

#### Task: Limiting Uploads

Research and review the best method to limit uploads with a specific prefix to
an S3 bucket.

## Further Reading

- Read through the [IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
  and be sure you're familiar with the ideas there.
