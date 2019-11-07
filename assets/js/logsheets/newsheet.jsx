import React from 'react';
import ReactDOM from 'react-dom';

import { connect } from 'react-redux';
import { Form, Button, Alert } from 'react-bootstrap';
import { list_jobs } from '../ajax';
import { Redirect } from 'react-router';

function state2props(state,props) {
   // console.log("state-----------------------------",state.forms.jobs)
    return {jobs: state.forms.jobs};
   //  let id = parseInt(props.id);
   //  return {id: id, jobs: state.jobs.get(id)};
}

class SheetNew extends React.Component {
    constructor (props) {
        super(props);

        this.state = {
            redirect: null,
        }


        list_jobs()
    }

    redirect(path) {
        this.setState({redirect: path});
    }

    // changed(data) {
    //     this.props.dispatch({
    //         type: 'NEW_LOG',
    //         data: data,
    //     });
    // }

    // file_changed(ev) {
    //     let input = ev.target;
    //     let file  = null;
    //     if (input.files.length > 0) {
    //         file = input.files[0];
    //     }
    //     this.changed({file: file});
    // }

    render() {
     var allRows=[]
     var eachRow=[]
     var taskno = 1;
     let jobs = this.props.jobs
     //   console.log("props--------------------------")
       // console.log(jobs)
     var jobcodeList=[]
       // console.log(jobs)
      jobs.forEach(function(job){
          jobcodeList.push(<option>{job.job_code}</option>)
         });
     console.log(jobcodeList)
     for(var i=0; i<8; i++){
         eachRow.push(<table>
             <tr>
                 <td class="offset-1">{i+1}</td>
                 <td class="offset-1"><Form.Control type="number" min={0} max={8} defaultValue={0}/></td>
                 <td class="offset-1"><Form.Control as="select">

                     {jobcodeList}
                 </Form.Control></td>
             </tr>
         </table>)
     }
        if (this.state.redirect) {
            return <Redirect to={this.state.redirect} />;
        }

        return (
            <div class="form-group">

                <h1>New Log</h1>
                {eachRow}

                <input type="submit" value="Submit" />
            </div>
        );
    }
}

export default connect(state2props)(SheetNew);