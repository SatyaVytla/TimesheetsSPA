import React from 'react';
import ReactDOM from 'react-dom';

import { connect } from 'react-redux';
import { Form, Button, Alert, Table } from 'react-bootstrap';
import { list_jobs } from '../ajax';
import { Redirect } from 'react-router';
import { submit_new_log } from '../ajax';

function state2props(state,props) {
   //console.log("state-----------------------------",state.forms.jobs)

    return {jobs: state.forms.jobs};

}

class SheetNew extends React.Component {
    constructor (props) {
        super(props);

        this.state = {
            redirect: null,
            hours:{},
            job_code:{}
        }


        list_jobs()
    }

    redirect(path) {
        this.setState({redirect: path});
    }


    changed(key, value) {
        let data = {}
        data[key] = value
        // hours = this.state.hours
        // console.log("data")
        // console.log(data)
        // // data.hours.push(data.hours)
        // this.setState({hours: hours})
        // data.hours = this.state.hours
        //console.log("state")
        //console.log(this.state)
        this.props.dispatch({
            type: 'NEW_LOG',
            data: data,
        });
    }

    render() {
     var allRows=[]
     var eachRow=[]
     var taskno = 1;
     let jobs = this.props.jobs
//   Attribution : https://github.com/hemanthnhs/CS5610-WebDev-HW7
     var jobcodeList=[<option disabled selected={true}>Select</option>]

      jobs.forEach(function(job){
          jobcodeList.push(<option>{job.job_code}</option>)
         });

     for(let i=0; i<8; i++){
         eachRow.push(
             <tr>
                 <td class="offset-1">{i+1}</td>
                 <td class="offset-1"><Form.Control type="number" id= {i} min={0} max={8} defaultValue={0} onChange={e => {this.changed("hours"+(i+1),e.target.value)}} /></td>
                 <td class="offset-1"><Form.Control as="select" id={i} onChange={e => {this.changed("job_code"+(i+1),e.target.value)}}>
                     {jobcodeList}
                 </Form.Control></td>
             </tr>
         )
     }
        if (this.state.redirect) {
            return <Redirect to={this.state.redirect} />;
        }

        return (
            <div class="form-group">

                <h1>New Log</h1>
                <h3>
                    <Form.Label>Date</Form.Label>
                    <Form.Control type="date" required={true} onChange={e => {this.changed("date_logged",e.target.value)}}/>
                </h3>
                <Table>
                    <thead>
                    <tr>
                        <td>Task no</td>
                        <td>Hours</td>
                        <td>Job Code</td>
                    </tr>
                    </thead>
                    <tbody>
                        {eachRow}
                    </tbody>
                </Table>
                <Form.Group controlId="submit">
                    <Button variant="primary"
                            onClick={() => submit_new_log(this)}>
                        submit</Button>
                </Form.Group>
            </div>
        );
    }
}

export default connect(state2props)(SheetNew);