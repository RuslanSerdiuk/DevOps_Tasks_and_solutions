#!/usr/bin/env python3
import argparse
import os
import requests

def create_project(url, header, **kwargs):
    
    '''
    :param url: variable contains link to GitLab API
    :param header: variable contains header of request with private token in it
    :param kwargs: variable contains script arguments
    :return:
    '''
    data = {"name": kwargs["project_name"]}
    print(data)
    return requests.post(url, headers=header, data=data).json()


def role(url, header, **kwargs):
    '''
    :param url: variable contains link to GitLab API
    :param header: variable contains header of request with private token in it
    :param kwargs: variable contains script arguments
    :return:
    '''
    action = kwargs["action"]
    access_level = str(kwargs["access_level"])
    project_id = str(kwargs["project_id"])
    user_id = str(kwargs["user_id"])

    if action == "add":
        data = {"user_id": user_id, "access_level": access_level}
        result = requests.post(url + project_id + "/members/", headers=header, data=data).json()

    elif action == "del":
        data = {"access_level": access_level}
        result = requests.delete(url + project_id + "/members/" + user_id, headers=header, data=data)

    elif action == "update":
        data = {"access_level": access_level}
        result = requests.put(url + project_id + "/members/" + user_id, headers=header, data=data).json()

    return result


def tag(url, header, **kwargs):
    '''
    :param url: variable contains link to GitLab API
    :param header: variable contains header of request with private token in it
    :param kwargs: variable contains script arguments
    :return:
    '''
    action = kwargs["action"]
    project_id = str(kwargs["project_id"])
    tag_name = str(kwargs["tag_name"])
    reference = kwargs["reference"]

    if action == "add":
        data = {"tag_name": tag_name, "ref": reference}
        result = requests.post(url + project_id + "/repository/tags", headers=header, data=data).json()

    elif action == 'del':
        result = requests.delete(url + project_id + "/repository/tags/" + tag_name, headers=header)

    return result


def issue(url, header, **kwargs):
    '''
    :param url: variable contains link to GitLab API
    :param header: variable contains header of request with private token in it
    :param kwargs: variable contains script arguments
    :return:
    '''
    project_id = kwargs["project_id"]
    data = {
        "title": kwargs["title"],
        "labels": kwargs["labels"],
        "description": kwargs["description"],
        "milestone_id": kwargs["milestone_id"],
        "due_date": kwargs["due_date"],
        "assignee_ids": kwargs["user_id"]
    }

    return requests.post(url + str(project_id) + "/issues", headers=header, data=data).json()


def main(arguments):
    '''
    :param arguments: variable contains script arguments
    :return:
    '''
    header = {"PRIVATE-TOKEN": os.getenv("API_KEY")}
    url = "https://git.epam.com/api/v4/projects/"
    tasks = {
        'create_project': create_project,
        'role': role,
        'tag': tag,
        'issue': issue,
    }

    result = tasks[arguments.task](url, header, **vars(arguments))

    print(result)


if __name__ == "__main__":
    cmdline_args = argparse.ArgumentParser()
    subparsers = cmdline_args.add_subparsers(help="Tasks", dest="task")

    create_project_parser = subparsers.add_parser("create_project")
    create_project_parser.add_argument("--project_name", type=str, help="Name of the project to create")

    role_parser = subparsers.add_parser("role")
    role_parser.add_argument("--action", choices=['add', 'del', 'update'], type=str)
    role_parser.add_argument("--access_level", type=int)
    role_parser.add_argument("--project_id", type=int)
    role_parser.add_argument("--user_id", type=int)

    tag_parser = subparsers.add_parser("tag")
    tag_parser.add_argument("--action", choices=['add', 'del', 'update'], type=str)
    tag_parser.add_argument("--tag_name", type=str)
    tag_parser.add_argument("--project_id", type=int)
    tag_parser.add_argument("--reference", type=str)

    issue_parser = subparsers.add_parser("issue")
    issue_parser.add_argument("--project_id", type=int)
    issue_parser.add_argument("--group_name", type=str)
    issue_parser.add_argument("--title", type=str)
    issue_parser.add_argument("--labels", type=str)
    issue_parser.add_argument("--description", type=str)
    issue_parser.add_argument("--milestone_id", type=int)
    issue_parser.add_argument("--due_date", type=str)
    issue_parser.add_argument("--user_id", type=int)

    args = cmdline_args.parse_args()
    main(args)



