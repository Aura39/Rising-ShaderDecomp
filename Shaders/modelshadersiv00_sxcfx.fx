sampler Color_1_sampler;
float4 CubeParam;
sampler Shadow_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
samplerCUBE cubemap_sampler;
float3 fog;
float4 g_All_Offset;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 light_Color;
float4 lightpos;
float4 prefogcolor_enhance;
float4 specularParam;

struct PS_IN
{
	float3 color : COLOR;
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	float4 r4;
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
	r1.x = 1 / ambient_rate.w;
	r0.xyz = r0.xyz * r1.xxx;
	r1.xyz = r0.xyz * i.color.xyz;
	r0.xyz = r0.xyz * i.color.xyz + specularParam.www;
	r2 = tex2D(cubemap_sampler, i.texcoord4);
	r2 = r2 * ambient_rate_rate.w;
	r2.xyz = r0.www * r2.xyz;
	r1.w = r2.w * CubeParam.y + CubeParam.x;
	r2.xyz = r1.www * r2.xyz;
	r3.xyz = r1.xyz * r2.xyz;
	r1.w = 1 / i.texcoord7.w;
	r4.xy = r1.ww * i.texcoord7.xy;
	r4.xy = r4.xy * float2(0.5, -0.5) + 0.5;
	r4.xy = r4.xy + g_TargetUvParam.xy;
	r4 = tex2D(Shadow_Tex_sampler, r4);
	r1.w = r4.z + g_ShadowUse.x;
	r4.xyz = ambient_rate_rate.xyz;
	r4.xyz = r1.www * r4.xyz + ambient_rate.xyz;
	r4.xyz = r4.xyz + i.texcoord2.xyz;
	r1.xyz = r1.xyz * r4.xyz;
	r4.xyz = r3.xyz * CubeParam.zzz + r1.xyz;
	r3.xyz = r3.xyz * CubeParam.zzz;
	r1.xyz = r1.xyz * -r3.xyz + r4.xyz;
	r2.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r2.w = 1 / sqrt(r2.w);
	r3.xyz = -i.texcoord1.xyz * r2.www + lightpos.xyz;
	r4.xyz = normalize(r3.xyz);
	r2.w = dot(r4.xyz, i.texcoord3.xyz);
	r3.x = pow(r2.w, specularParam.z);
	r3.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r3.z = (-r3.y >= 0) ? 0 : 1;
	r3.y = r3.y * r3.z;
	r2.w = (-r2.w >= 0) ? 0 : r3.z;
	r2.w = r3.x * r2.w;
	r3.xyz = r3.yyy * light_Color.xyz;
	r3.xyz = r2.www * r3.xyz;
	r3.xyz = r0.www * r3.xyz;
	r3.xyz = r1.www * r3.xyz;
	r0.w = abs(specularParam.x);
	r3.xyz = r0.www * r3.xyz;
	r0.xyz = r3.xyz * r0.xyz + r1.xyz;
	r1.z = CubeParam.z;
	r0.w = -r1.z + 1;
	r0.xyz = r2.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
