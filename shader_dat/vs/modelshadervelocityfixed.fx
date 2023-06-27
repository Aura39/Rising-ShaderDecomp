float4 g_BlurParam;
float4x4 g_Projection;
float4x4 g_View;
float4x4 g_World;
float4x4 g_WorldView;
float4x4 g_oldView;
float4x4 g_oldWorld;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float2 texcoord2 : TEXCOORD2;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	float4 r6;
	float4 r7;
	float4 r8;
	float4 r9;
	r0 = transpose(g_View)[0];
	r1 = r0.y * transpose(g_World)[1];
	r1 = transpose(g_World)[0] * r0.x + r1;
	r1 = transpose(g_World)[2] * r0.z + r1;
	r1 = transpose(g_World)[3] * r0.w + r1;
	r2 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r1.x = dot(r2, r1);
	r3 = transpose(g_View)[1];
	r4 = r3.y * transpose(g_World)[1];
	r4 = transpose(g_World)[0] * r3.x + r4;
	r4 = transpose(g_World)[2] * r3.z + r4;
	r4 = transpose(g_World)[3] * r3.w + r4;
	r1.y = dot(r2, r4);
	r4 = transpose(g_View)[2];
	r5 = r4.y * transpose(g_World)[1];
	r5 = transpose(g_World)[0] * r4.x + r5;
	r5 = transpose(g_World)[2] * r4.z + r5;
	r5 = transpose(g_World)[3] * r4.w + r5;
	r1.z = dot(r2, r5);
	r5 = transpose(g_View)[3];
	r6 = r5.y * transpose(g_World)[1];
	r6 = transpose(g_World)[0] * r5.x + r6;
	r6 = transpose(g_World)[2] * r5.z + r6;
	r6 = transpose(g_World)[3] * r5.w + r6;
	r1.w = dot(r2, r6);
	o.texcoord1.w = dot(r1, transpose(g_Projection)[3]);
	r0.xyz = r0.yxz + -transpose(g_oldView)[0].yxz;
	r0.w = g_BlurParam.w;
	r0.x = r0.w * r0.x + transpose(g_oldView)[0].y;
	r6 = r0.x * transpose(g_oldWorld)[1];
	r0.x = r0.w * r0.z + transpose(g_oldView)[0].z;
	r0.y = r0.w * r0.y + transpose(g_oldView)[0].x;
	r6 = transpose(g_oldWorld)[0] * r0.y + r6;
	r6 = transpose(g_oldWorld)[2] * r0.x + r6;
	r7.x = transpose(g_oldView)[0].w;
	r7.y = transpose(g_oldView)[1].w;
	r7.z = transpose(g_oldView)[2].w;
	r7.w = transpose(g_oldView)[3].w;
	r8.x = transpose(g_View)[0].w;
	r8.y = transpose(g_View)[1].w;
	r8.z = transpose(g_View)[2].w;
	r8.w = transpose(g_View)[3].w;
	r9 = lerp(r8, r7, g_BlurParam.w);
	r6 = transpose(g_oldWorld)[3] * r9.x + r6;
	r6.x = dot(r2, r6);
	r0.xyz = r3.xyz + -transpose(g_oldView)[1].xyz;
	r0.y = r0.w * r0.y + transpose(g_oldView)[1].y;
	r3 = r0.y * transpose(g_oldWorld)[1];
	r0.y = r0.w * r0.z + transpose(g_oldView)[1].z;
	r0.x = r0.w * r0.x + transpose(g_oldView)[1].x;
	r3 = transpose(g_oldWorld)[0] * r0.x + r3;
	r3 = transpose(g_oldWorld)[2] * r0.y + r3;
	r3 = transpose(g_oldWorld)[3] * r9.y + r3;
	r6.y = dot(r2, r3);
	r0.xyz = r4.xzy + -transpose(g_oldView)[2].xzy;
	r0.z = r0.w * r0.z + transpose(g_oldView)[2].y;
	r3 = r0.z * transpose(g_oldWorld)[1];
	r0.y = r0.w * r0.y + transpose(g_oldView)[2].z;
	r0.x = r0.w * r0.x + transpose(g_oldView)[2].x;
	r3 = transpose(g_oldWorld)[0] * r0.x + r3;
	r3 = transpose(g_oldWorld)[2] * r0.y + r3;
	r3 = transpose(g_oldWorld)[3] * r9.z + r3;
	r6.z = dot(r2, r3);
	r3.xyw = r5.xzy + -transpose(g_oldView)[3].xzy;
	r0.x = r0.w * r3.w + transpose(g_oldView)[3].y;
	r4 = r0.x * transpose(g_oldWorld)[1];
	r0.x = r0.w * r3.y + transpose(g_oldView)[3].z;
	r0.y = r0.w * r3.x + transpose(g_oldView)[3].x;
	r3 = transpose(g_oldWorld)[0] * r0.y + r4;
	r0 = transpose(g_oldWorld)[2] * r0.x + r3;
	r0 = transpose(g_oldWorld)[3] * r9.w + r0;
	r6.w = dot(r2, r0);
	o.texcoord1.z = dot(r6, transpose(g_Projection)[3]);
	r0.x = dot(r2, transpose(g_WorldView)[0]);
	r0.y = dot(r2, transpose(g_WorldView)[1]);
	r0.z = dot(r2, transpose(g_WorldView)[2]);
	r0.w = dot(r2, transpose(g_WorldView)[3]);
	o.position.x = dot(r0, transpose(g_Projection)[0]);
	o.position.y = dot(r0, transpose(g_Projection)[1]);
	o.position.z = dot(r0, transpose(g_Projection)[2]);
	o.position.w = dot(r0, transpose(g_Projection)[3]);
	r0.x = dot(r6, transpose(g_Projection)[0]);
	r0.y = dot(r6, transpose(g_Projection)[1]);
	r2.x = dot(r1, transpose(g_Projection)[0]);
	r2.y = dot(r1, transpose(g_Projection)[1]);
	r0.xy = r0.xy + -r2.xy;
	o.texcoord2 = r0.xy * g_BlurParam.zz + r2.xy;
	o.texcoord1.xy = r2.xy;
	o.texcoord = i.texcoord.xy;

	return o;
}
