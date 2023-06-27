sampler Color_1_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float3 fog;
float4 g_All_Offset;
float4 prefogcolor_enhance;
float4 sectionParam;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float r2;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1.xy = -r0.yy + r0.xz;
	r2.x = max(abs(r1.x), abs(r1.y));
	r1.x = r2.x + -0.015625;
	r1.y = (-r1.x >= 0) ? 0 : 1;
	r1.x = (r1.x >= 0) ? -0 : -1;
	r1.x = r1.x + r1.y;
	r1.x = (r1.x >= 0) ? -r1.x : -0;
	r0.xz = (r1.xx >= 0) ? r0.yy : r0.xz;
	r1.w = sectionParam.w;
	r1.x = r1.w * 0.1;
	r1.x = abs(r1.x) * sectionParam.w;
	r0.w = r0.w * r1.x;
	r0.xyz = r0.www * 0.01 + r0.xyz;
	r0.w = r0.w * 0.01;
	r1.xyz = r0.www * sectionParam.xyz;
	r0.xyz = r0.xyz * ambient_rate.xyz;
	r0.xyz = r0.xyz * ambient_rate_rate.xyz + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
