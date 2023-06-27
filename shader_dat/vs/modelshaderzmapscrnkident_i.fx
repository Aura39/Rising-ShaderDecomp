float g_DentRate;
float4x4 g_Proj;
float4x4 g_View;

struct VS_IN
{
	float4 position : POSITION;
	float4 color : COLOR;
	float4 normal : NORMAL;
	float4 texcoord : TEXCOORD;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float4 texcoord4 : TEXCOORD4;
	float4 texcoord5 : TEXCOORD5;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float2 texcoord1 : TEXCOORD1;
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
	r0.x = -0.5 + i.color.y;
	r0.xyz = r0.xxx * i.normal.xyz;
	r0.xyz = r0.xyz * g_DentRate.xxx;
	r0.xyz = r0.xyz * -2 + i.position.xyz;
	r0.w = 1;
	r1.x = dot(i.texcoord2, transpose(g_View)[0]);
	r1.y = dot(i.texcoord2, transpose(g_View)[1]);
	r1.z = dot(i.texcoord2, transpose(g_View)[2]);
	r1.w = dot(i.texcoord2, transpose(g_View)[3]);
	r2.x = dot(r1, transpose(g_Proj)[0]);
	r3.x = dot(i.texcoord3, transpose(g_View)[0]);
	r3.y = dot(i.texcoord3, transpose(g_View)[1]);
	r3.z = dot(i.texcoord3, transpose(g_View)[2]);
	r3.w = dot(i.texcoord3, transpose(g_View)[3]);
	r2.y = dot(r3, transpose(g_Proj)[0]);
	r4.x = dot(i.texcoord4, transpose(g_View)[0]);
	r4.y = dot(i.texcoord4, transpose(g_View)[1]);
	r4.z = dot(i.texcoord4, transpose(g_View)[2]);
	r4.w = dot(i.texcoord4, transpose(g_View)[3]);
	r2.z = dot(r4, transpose(g_Proj)[0]);
	r5.x = dot(i.texcoord5, transpose(g_View)[0]);
	r5.y = dot(i.texcoord5, transpose(g_View)[1]);
	r5.z = dot(i.texcoord5, transpose(g_View)[2]);
	r5.w = dot(i.texcoord5, transpose(g_View)[3]);
	r2.w = dot(r5, transpose(g_Proj)[0]);
	r2.x = dot(r0, r2);
	r6.x = dot(r1, transpose(g_Proj)[1]);
	r6.y = dot(r3, transpose(g_Proj)[1]);
	r6.z = dot(r4, transpose(g_Proj)[1]);
	r6.w = dot(r5, transpose(g_Proj)[1]);
	r2.y = dot(r0, r6);
	r6.x = dot(r1, transpose(g_Proj)[2]);
	r1.x = dot(r1, transpose(g_Proj)[3]);
	r6.y = dot(r3, transpose(g_Proj)[2]);
	r1.y = dot(r3, transpose(g_Proj)[3]);
	r6.z = dot(r4, transpose(g_Proj)[2]);
	r1.z = dot(r4, transpose(g_Proj)[3]);
	r6.w = dot(r5, transpose(g_Proj)[2]);
	r1.w = dot(r5, transpose(g_Proj)[3]);
	r2.w = dot(r0, r1);
	r2.z = dot(r0, r6);
	o.position = r2;
	o.texcoord = r2;
	o.texcoord1 = i.texcoord.xy;

	return o;
}
