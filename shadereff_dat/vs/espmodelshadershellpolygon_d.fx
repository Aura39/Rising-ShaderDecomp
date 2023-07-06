float4 g_CommonParam;
float4x4 g_Proj;
float4x4 g_View;
float4x4 g_World;
float4x4 g_WorldMatrix;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 normal : NORMAL;
	float4 tangent : TANGENT;
};

struct VS_OUT
{
	float4 position : POSITION;
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
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
	r0 = transpose(g_World)[1];
	r1 = r0 * transpose(g_WorldMatrix)[1].y;
	r2 = transpose(g_World)[0];
	r1 = r2 * transpose(g_WorldMatrix)[1].x + r1;
	r3 = transpose(g_World)[2];
	r1 = r3 * transpose(g_WorldMatrix)[1].z + r1;
	r4 = transpose(g_World)[3];
	r1 = r4 * transpose(g_WorldMatrix)[1].w + r1;
	r5 = r1 * transpose(g_View)[0].y;
	r6 = r0 * transpose(g_WorldMatrix)[0].y;
	r6 = r2 * transpose(g_WorldMatrix)[0].x + r6;
	r6 = r3 * transpose(g_WorldMatrix)[0].z + r6;
	r6 = r4 * transpose(g_WorldMatrix)[0].w + r6;
	r5 = r6 * transpose(g_View)[0].x + r5;
	r7 = r0 * transpose(g_WorldMatrix)[2].y;
	r7 = r2 * transpose(g_WorldMatrix)[2].x + r7;
	r7 = r3 * transpose(g_WorldMatrix)[2].z + r7;
	r7 = r4 * transpose(g_WorldMatrix)[2].w + r7;
	r5 = r7 * transpose(g_View)[0].z + r5;
	r0 = r0 * transpose(g_WorldMatrix)[3].y;
	r0 = r2 * transpose(g_WorldMatrix)[3].x + r0;
	r0 = r3 * transpose(g_WorldMatrix)[3].z + r0;
	r0 = r4 * transpose(g_WorldMatrix)[3].w + r0;
	r2 = r0 * transpose(g_View)[0].w + r5;
	o.texcoord1.x = dot(i.normal.xyz, r2.xyz);
	r3 = r1 * transpose(g_View)[1].y;
	r3 = r6 * transpose(g_View)[1].x + r3;
	r3 = r7 * transpose(g_View)[1].z + r3;
	r3 = r0 * transpose(g_View)[1].w + r3;
	o.texcoord1.y = dot(i.normal.xyz, r3.xyz);
	r4 = r1 * transpose(g_View)[2].y;
	r1 = r1 * transpose(g_View)[3].y;
	r1 = r6 * transpose(g_View)[3].x + r1;
	r4 = r6 * transpose(g_View)[2].x + r4;
	r4 = r7 * transpose(g_View)[2].z + r4;
	r1 = r7 * transpose(g_View)[3].z + r1;
	r1 = r0 * transpose(g_View)[3].w + r1;
	r0 = r0 * transpose(g_View)[2].w + r4;
	o.texcoord1.z = dot(i.normal.xyz, r0.xyz);
	r4 = i.tangent * 2 + -1;
	r4.xyz = r4.www * r4.xyz;
	o.texcoord2.x = dot(r4.xyz, r2.xyz);
	o.texcoord2.y = dot(r4.xyz, r3.xyz);
	o.texcoord2.z = dot(r4.xyz, r0.xyz);
	r4 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r0.x = dot(r4, r0);
	r0.z = r0.x + g_CommonParam.x;
	r0.x = dot(r4, r2);
	r0.y = dot(r4, r3);
	r0.w = dot(r4, r1);
	r1.x = dot(r0, transpose(g_Proj)[0]);
	r1.y = dot(r0, transpose(g_Proj)[1]);
	r1.z = dot(r0, transpose(g_Proj)[2]);
	r1.w = dot(r0, transpose(g_Proj)[3]);
	o.position = r1;
	o.texcoord3 = r1;
	o.texcoord = i.texcoord.xy;
	o.texcoord2.w = i.tangent.w * 2 + -1;

	return o;
}
