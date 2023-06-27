float4 g_All_Offset_vs;
float4 g_BlurParam;
float4x4 g_OldViewProjection;
float4 g_normalmapRate_vs;
float4x4 proj;
float4x4 view;

struct VS_IN
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float4 texcoord4 : TEXCOORD4;
	float4 texcoord5 : TEXCOORD5;
	float4 texcoord6 : TEXCOORD6;
};

struct VS_OUT
{
	float4 position : POSITION;
	float4 texcoord : TEXCOORD;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
};

VS_OUT main(VS_IN i)
{
	VS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	r0.x = dot(i.texcoord2, transpose(view)[0]);
	r0.y = dot(i.texcoord3, transpose(view)[0]);
	r0.z = dot(i.texcoord4, transpose(view)[0]);
	r0.w = dot(i.texcoord5, transpose(view)[0]);
	r1 = i.position.xyzx * float4(1, 1, 1, 0) + float4(0, 0, 0, 1);
	r0.x = dot(r1, r0);
	r2.x = dot(i.texcoord2, transpose(view)[1]);
	r2.y = dot(i.texcoord3, transpose(view)[1]);
	r2.z = dot(i.texcoord4, transpose(view)[1]);
	r2.w = dot(i.texcoord5, transpose(view)[1]);
	r0.y = dot(r1, r2);
	r2.x = dot(i.texcoord2, transpose(view)[2]);
	r2.y = dot(i.texcoord3, transpose(view)[2]);
	r2.z = dot(i.texcoord4, transpose(view)[2]);
	r2.w = dot(i.texcoord5, transpose(view)[2]);
	r0.z = dot(r1, r2);
	r2.x = dot(i.texcoord2, transpose(view)[3]);
	r2.y = dot(i.texcoord3, transpose(view)[3]);
	r2.z = dot(i.texcoord4, transpose(view)[3]);
	r2.w = dot(i.texcoord5, transpose(view)[3]);
	r0.w = dot(r1, r2);
	o.position.z = dot(r0, transpose(proj)[2]);
	r1 = i.texcoord3;
	r1 = r1 * i.position.y;
	r2 = i.texcoord2;
	r1 = i.position.x * r2 + r1;
	r2 = i.texcoord4;
	r1 = i.position.z * r2 + r1;
	r1 = r1 + i.texcoord5;
	o.texcoord7.z = dot(r1, transpose(g_OldViewProjection)[3]);
	r2.x = dot(r1, transpose(g_OldViewProjection)[0]);
	r2.y = dot(r1, transpose(g_OldViewProjection)[1]);
	r1.x = dot(r0, transpose(proj)[0]);
	r1.y = dot(r0, transpose(proj)[1]);
	r1.w = dot(r0, transpose(proj)[3]);
	r0.xy = -r1.xy + r2.xy;
	o.texcoord8.xy = r0.xy * g_BlurParam.zz + r1.xy;
	r0.z = -1;
	r0.x = r0.z + g_normalmapRate_vs.w;
	r2 = i.texcoord6;
	r0.yz = i.texcoord1.xy * r2.xy + r2.zw;
	r2.xy = i.texcoord.xy;
	r0.yz = r0.yz + -r2.xy;
	o.texcoord.zw = r0.xx * r0.yz + r2.xy;
	r0.yz = g_normalmapRate_vs.yz;
	o.texcoord8.zw = i.texcoord.xy * r0.yz + g_All_Offset_vs.xy;
	o.position.xyw = r1.xyw;
	o.texcoord7.xyw = r1.xyw;
	o.texcoord.xy = i.texcoord.xy;

	return o;
}
