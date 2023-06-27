sampler Color_1_sampler;
float4 CubeParam;
float4 ambient_rate;
float4 ambient_rate_rate;
samplerCUBE cubemap_sampler;
float4 eyeLightDir;
float3 fog;
float4 g_All_Offset;
float4 light_Color;
float4 prefogcolor_enhance;
float4 specularParam;
float4 tile;
sampler tripleMask_sampler;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float3 r4;
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
	r1.xy = tile.xy * i.texcoord.xy;
	r1 = tex2D(tripleMask_sampler, r1);
	r0.w = r0.w * ambient_rate.w;
	r2.xyz = r0.xyz * r1.xxx;
	r2.xyz = r2.xyz * ambient_rate.xyz;
	r2.xyz = r2.xyz * ambient_rate_rate.xyz;
	r3 = tex2D(cubemap_sampler, i.texcoord4);
	r3 = r3 * ambient_rate_rate.w;
	r1.xyw = r1.yyy * r3.xyz;
	r2.w = r3.w * CubeParam.y + CubeParam.x;
	r1.xyw = r1.xyw * r2.www;
	r3.xyz = r0.xyz * r1.xyw;
	r0.xyz = r0.xyz + specularParam.www;
	r4.xyz = r3.xyz * CubeParam.zzz + r2.xyz;
	r3.xyz = r3.xyz * CubeParam.zzz;
	r2.xyz = r2.xyz * -r3.xyz + r4.xyz;
	r3.xyz = normalize(eyeLightDir.xyz);
	r4.xyz = normalize(i.texcoord3.xyz);
	r2.w = dot(r3.xyz, r4.xyz);
	r3.x = pow(r2.w, specularParam.z);
	r3.xyz = r3.xxx * light_Color.xyz;
	r3.xyz = r1.zzz * r3.xyz;
	r1.z = abs(specularParam.x);
	r3.xyz = r1.zzz * r3.xyz;
	r2.xyz = r3.xyz * r0.xyz + r2.xyz;
	r0.xyz = r0.xyz * r3.xyz;
	r1.z = CubeParam.z;
	r1.z = -r1.z + 1;
	r1.xyz = r1.xyw * r1.zzz + r2.xyz;
	r2.xyz = fog.xyz;
	r1.xyz = r1.xyz * prefogcolor_enhance.xyz + -r2.xyz;
	o.xyz = i.texcoord1.www * r1.xyz + fog.xyz;
	r1.x = max(r0.x, r0.y);
	r2.x = max(r1.x, r0.z);
	r0.x = r2.x * specularParam.x;
	r0.y = max(CubeParam.x, CubeParam.y);
	r0.x = r3.w * r0.y + r0.x;
	r1.x = max(r0.x, r0.w);
	r0.x = dot(i.texcoord1.xyz, i.texcoord1.xyz);
	r0.x = 1 / sqrt(r0.x);
	r0.x = 1 / r0.x;
	r0.x = r0.x * 0.44444445;
	r0.x = -r0.x + 1;
	r0.x = r0.x * 5;
	r0.x = r0.x * r1.x;
	r0.x = r0.x * prefogcolor_enhance.w;
	o.w = r0.x;

	return o;
}
